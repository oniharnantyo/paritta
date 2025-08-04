import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/ui/core/app_constants.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ParittaScreen extends StatefulWidget {
  const ParittaScreen({super.key});

  @override
  State<ParittaScreen> createState() => _ParittaScreenState();
}

class _ParittaScreenState extends State<ParittaScreen> {
  int _selectedMenuIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final i10n = AppLocalizations.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isTablet = mediaQuery.size.width > 600;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final useTwoColumnLayout = isTablet && isLandscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        return CustomScrollView(
          slivers: [
            _buildAppBar(textTheme, i10n, isTablet),
            _buildContent(textTheme, isTablet, isLandscape, useTwoColumnLayout),
          ],
        );
      },
    );
  }

  /// Builds the app bar with search functionality
  Widget _buildAppBar(
      TextTheme textTheme, AppLocalizations i10n, bool isTablet) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: isTablet
          ? AppConstants.tabletAppBarHeight + 50
          : AppConstants.mobileAppBarHeight + 50,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final isCollapsed = constraints.maxHeight <= kToolbarHeight + 40;

          return FlexibleSpaceBar(
            title: isCollapsed ? const Text('Paritta') : null,
            centerTitle: true,
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('Paritta',
                    style: isTablet
                        ? textTheme.headlineMedium
                        : textTheme.headlineSmall),
                Padding(
                  padding: EdgeInsets.all(isTablet
                      ? AppConstants.tabletHorizontalPadding
                      : AppConstants.mobileHorizontalPadding),
                  child: SearchBar(
                    leading: const Icon(Icons.search),
                    hintText: i10n.parittaSearchParitta,
                    onChanged: (String value) {
                      context
                          .read<ParittaBloc>()
                          .add(MainMenuRequested(search: value));
                    },
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                      (states) {
                        return RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            color:
                                Theme.of(context).dividerColor.withOpacity(0.5),
                            width: 1.0,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Builds the main content based on the current state
  Widget _buildContent(
    TextTheme textTheme,
    bool isTablet,
    bool isLandscape,
    bool useTwoColumnLayout,
  ) {
    return BlocConsumer<ParittaBloc, ParittaState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == ParittaStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error loading menus')),
            );
        }
      },
      builder: (context, state) {
        return _buildContentByState(
          context,
          state,
          textTheme,
          isTablet,
          isLandscape,
          useTwoColumnLayout,
        );
      },
    );
  }

  /// Builds content based on the current state of the bloc
  Widget _buildContentByState(
    BuildContext context,
    ParittaState state,
    TextTheme textTheme,
    bool isTablet,
    bool isLandscape,
    bool useTwoColumnLayout,
  ) {
    if (state.status == ParittaStatus.loading && state.categoryTitles.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    } else if (state.status != ParittaStatus.success &&
        state.categoryTitles.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(),
      );
    }

    // If we have category titles but no menus, show the category titles
    if (state.categoryTitles.isNotEmpty && state.menus.isEmpty) {
      return _buildCategoryTitles(context, state, textTheme, isTablet);
    }

    // Ensure we have menus and a valid selected index
    if (state.menus.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('No menus available')),
      );
    }

    // Make sure selected index is within bounds
    if (_selectedMenuIndex >= state.menus.length || _selectedMenuIndex < 0) {
      _selectedMenuIndex = 0;
    }

    // Additional safety check for the selected menu's submenus
    final selectedMenu = state.menus[_selectedMenuIndex];
    if (selectedMenu.menus.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(child: Text('No submenus available')),
      );
    }

    if (useTwoColumnLayout) {
      return _buildTwoColumnLayout(context, state, textTheme, isTablet);
    }

    return _buildSingleColumnLayout(context, state, textTheme, isTablet);
  }

  /// Builds the category titles display
  Widget _buildCategoryTitles(
    BuildContext context,
    ParittaState state,
    TextTheme textTheme,
    bool isTablet,
  ) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet
            ? AppConstants.tabletHorizontalPadding
            : AppConstants.mobileHorizontalPadding,
        vertical: isTablet
            ? AppConstants.tabletVerticalPadding
            : AppConstants.mobileVerticalPadding,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Categories:',
              style: isTablet ? textTheme.headlineSmall : textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: state.categoryTitles.map((title) {
                return Chip(
                  label: Text(title),
                  backgroundColor: Theme.of(context).colorScheme.secondary,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the two-column layout for tablets in landscape mode
  Widget _buildTwoColumnLayout(
    BuildContext context,
    ParittaState state,
    TextTheme textTheme,
    bool isTablet,
  ) {
    final selectedMenu = state.menus[_selectedMenuIndex];

    return SliverPadding(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet
            ? AppConstants.tabletHorizontalPadding
            : AppConstants.mobileHorizontalPadding,
      ),
      sliver: SliverFillRemaining(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left column - Menu titles
            _buildMenuTitlesColumn(context, state, textTheme),
            // Right column - Grid of items for selected menu
            _buildMenuItemsColumn(context, selectedMenu, isTablet),
          ],
        ),
      ),
    );
  }

  /// Builds the left column with menu titles
  Widget _buildMenuTitlesColumn(
    BuildContext context,
    ParittaState state,
    TextTheme textTheme,
  ) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: const EdgeInsets.only(right: 16),
        child: ListView.builder(
          itemCount: state.menus.length,
          itemBuilder: (context, index) {
            final menu = state.menus[index];
            final isSelected = _selectedMenuIndex == index;
            return Card(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : null,
              elevation: isSelected ? 2 : 1,
              child: ListTile(
                title: Text(
                  menu.title ?? 'Untitled',
                  style: isSelected
                      ? textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer)
                      : textTheme.titleMedium,
                ),
                selected: isSelected,
                onTap: () {
                  setState(() {
                    _selectedMenuIndex = index;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }

  /// Builds the right column with menu items
  Widget _buildMenuItemsColumn(
    BuildContext context,
    Menu selectedMenu,
    bool isTablet,
  ) {
    print(selectedMenu.menus);

    return Expanded(
      flex: 2,
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.8,
          ),
          itemCount: selectedMenu.menus.length,
          itemBuilder: (BuildContext context, int index) {
            // Additional safety check
            if (index >= selectedMenu.menus.length) {
              return const SizedBox();
            }

            final menuItem = selectedMenu.menus[index];
            return _buildMenuItemCard(context, menuItem);
          },
        ),
      ),
    );
  }

  /// Builds the single column layout for phones and tablets in portrait mode
  Widget _buildSingleColumnLayout(
    BuildContext context,
    ParittaState state,
    TextTheme textTheme,
    bool isTablet,
  ) {
    return MultiSliver(
      children: state.menus.map((menu) {
        // Safety check for menu
        if (menu.menus.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox());
        }

        return SliverPadding(
          padding: EdgeInsets.symmetric(
            horizontal: isTablet
                ? AppConstants.tabletHorizontalPadding
                : AppConstants.mobileHorizontalPadding,
            vertical: isTablet
                ? AppConstants.tabletVerticalPadding / 2
                : AppConstants.mobileVerticalPadding / 2,
          ),
          sliver: MultiSliver(
            children: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    menu.title ?? 'Untitled',
                    style:
                        isTablet ? textTheme.titleLarge : textTheme.titleMedium,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 200,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      return GridView.builder(
                        scrollDirection: Axis.horizontal,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1, // 1 row
                          mainAxisSpacing: 10,
                          childAspectRatio: 10 / 8,
                        ),
                        shrinkWrap: true,
                        itemCount: menu.menus.length,
                        itemBuilder: (BuildContext context, int index) {
                          // Additional safety check
                          if (index >= menu.menus.length) {
                            return const SizedBox();
                          }

                          final menuItem = menu.menus[index];
                          return _buildMenuItemCard(context, menuItem);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  /// Builds a single menu item card
  Widget _buildMenuItemCard(BuildContext context, MenuItem menuItem) {
    // Safety check for menuItem
    if (menuItem.id.isEmpty) {
      return const Card.outlined(child: SizedBox());
    }

    return Card.outlined(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.read<ParittaBloc>().add(LastReadMenuSaved(menuItem));
          context.push(
            Uri(
              path: '/paritta/list/${menuItem.id}',
              queryParameters: {'title': menuItem.title},
            ).toString(),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    // square image
                    child: Image.asset(
                      menuItem.image ??
                          'assets/images/tuntunan_puja_bhakti.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton.filledTonal(
                      onPressed: () {
                        if (menuItem.isFavorite ?? false) {
                          context
                              .read<ParittaBloc>()
                              .add(FavoriteMenuDeleted(menuItem.id));
                        } else {
                          context
                              .read<ParittaBloc>()
                              .add(FavoriteMenuAdded(menuItem));
                        }
                      },
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      constraints:
                          const BoxConstraints(maxHeight: 24, maxWidth: 24),
                      icon: const Icon(
                        Icons.favorite_border,
                        size: 18,
                      ),
                      isSelected: menuItem.isFavorite,
                      selectedIcon: const Icon(
                        Icons.favorite,
                        color: Colors.redAccent,
                        size: 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
            ListTile(
              title: Text(
                menuItem.title ?? 'Untitled',
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
