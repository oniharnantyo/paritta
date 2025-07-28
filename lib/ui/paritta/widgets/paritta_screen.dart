import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/ui/core/app_constants.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ParittaScreen extends StatelessWidget {
  const ParittaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final i10n = AppLocalizations.of(context);

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: AppConstants.mobileAppBarHeight + 50,
          flexibleSpace: LayoutBuilder(
            builder: (context, constraints) {
              final isCollapsed = constraints.maxHeight <= kToolbarHeight + 40;

              return FlexibleSpaceBar(
                title: isCollapsed ? const Text('Paritta') : null,
                centerTitle: true,
                background: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Paritta', style: textTheme.headlineMedium),
                    Padding(
                      padding: const EdgeInsets.all(AppConstants.mobileHorizontalPadding),
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
                                color: Theme.of(context).dividerColor.withOpacity(0.5),
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
        ),
        BlocListener<ParittaBloc, ParittaState>(
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
          child:
              BlocBuilder<ParittaBloc, ParittaState>(builder: (context, state) {
            if (state.status == ParittaStatus.loading) {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state.status != ParittaStatus.success) {
              return const SliverToBoxAdapter(
                child: SizedBox(),
              );
            }

            return MultiSliver(
              children: state.menus.map(
                (menu) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mobileHorizontalPadding,
                        vertical: AppConstants.mobileVerticalPadding / 2),
                    sliver: MultiSliver(
                      children: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              menu.title,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: 200,
                            child: GridView.builder(
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
                                final menuItem = menu.menus[index];
                                return Card.outlined(
                                  clipBehavior: Clip.hardEdge,
                                  child: InkWell(
                                    onTap: () {
                                      context
                                          .read<ParittaBloc>()
                                          .add(LastReadMenuSaved(menuItem));
                                      context.push(
                                        Uri(
                                          path: '/paritta/list/${menuItem.id}',
                                          queryParameters: {
                                            'title': menuItem.title
                                          },
                                        ).toString(),
                                      );
                                    },
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                bottomLeft: Radius.circular(16),
                                                bottomRight:
                                                    Radius.circular(16),
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
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                IconButton.filledTonal(
                                                  onPressed: () {
                                                    if (menuItem.isFavorite ??
                                                        false) {
                                                      context
                                                          .read<ParittaBloc>()
                                                          .add(
                                                              FavoriteMenuDeleted(
                                                                  menuItem.id));
                                                    } else {
                                                      context
                                                          .read<ParittaBloc>()
                                                          .add(
                                                              FavoriteMenuAdded(
                                                                  menuItem));
                                                    }
                                                  },
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 3,
                                                      vertical: 3),
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxHeight: 24,
                                                          maxWidth: 24),
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
                                            menuItem.title,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                          ),
                                        ),
                                      ],
                                    ),
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
              ).toList(),
            );
          }),
        ),
      ],
    );
  }
}
