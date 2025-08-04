import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lunar/lunar.dart';
import 'package:paritta_app/ui/core/app_constants.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/home/bloc/home_bloc.dart';
import 'package:paritta_app/ui/home/cubit/home_tab_cubit.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_screen.dart';
import 'package:paritta_app/ui/setting/bloc/setting_bloc.dart';
import 'package:paritta_app/ui/setting/widgets/setting_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeTabCubit cubit) => cubit.state.tab);
    final colorScheme = Theme.of(context).colorScheme;
    final i10n = AppLocalizations.of(context);
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final isTablet = mediaQuery.size.width > 600;

    final useNavigationRail = isLandscape && isTablet;

    final navigationBar = NavigationBar(
      backgroundColor: colorScheme.surfaceContainer,
      indicatorColor: colorScheme.secondaryContainer,
      selectedIndex: selectedTab.index,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.read<HomeBloc>()
              ..add(const FavoriteMenusRequested())
              ..add(const LastReadMenuRequested())
              ..add(const TodayQuoteRequested());
          case 1:
            context.read<ParittaBloc>()
              ..add(const MainMenuRequested())
              ..add(const CategoryTitlesRequested());
          case 2:
            context.read<SettingBloc>().add(const SettingAppConfigRequested());
        }
        context.read<HomeTabCubit>().setTab(index);
      },
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: i10n.homeNavbarTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.menu_book_outlined),
          selectedIcon: const Icon(Icons.menu_book),
          label: i10n.parittaNavbarTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.map_outlined),
          selectedIcon: const Icon(Icons.map),
          label: i10n.guideNavbarTitle,
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: i10n.settingNavbarTitle,
        ),
      ],
    );

    final navigationRail = NavigationRail(
      backgroundColor: colorScheme.surfaceContainer,
      indicatorColor: colorScheme.secondaryContainer,
      selectedIndex: selectedTab.index,
      onDestinationSelected: (index) {
        switch (index) {
          case 0:
            context.read<HomeBloc>()
              ..add(const FavoriteMenusRequested())
              ..add(const LastReadMenuRequested())
              ..add(const TodayQuoteRequested());
          case 1:
            context.read<ParittaBloc>().add(const MainMenuRequested());
          case 2:
            context.read<SettingBloc>().add(const SettingAppConfigRequested());
        }
        context.read<HomeTabCubit>().setTab(index);
      },
      labelType: NavigationRailLabelType.all,
      destinations: [
        NavigationRailDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: Text(i10n.homeNavbarTitle),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.menu_book_outlined),
          selectedIcon: const Icon(Icons.menu_book),
          label: Text(i10n.parittaNavbarTitle),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.map_outlined),
          selectedIcon: const Icon(Icons.map),
          label: Text(i10n.guideNavbarTitle),
        ),
        NavigationRailDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: Text(i10n.settingNavbarTitle),
        ),
      ],
    );

    if (useNavigationRail) {
      return Scaffold(
        body: Row(
          children: [
            navigationRail,
            Expanded(
              child: IndexedStack(
                index: selectedTab.index,
                children: const [
                  HomePage(),
                  ParittaScreen(),
                  Placeholder(),
                  SettingScreen(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [
          HomePage(),
          ParittaScreen(),
          Placeholder(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: navigationBar,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    final i10n = AppLocalizations.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final screenHeight = constraints.maxHeight;
        final isTablet = screenWidth > 600;
        final isLandscape = screenWidth > screenHeight;
        final useTwoColumnLayout = isTablet && isLandscape;

        final lunarDay = Lunar.fromDate(DateTime.now()).getDay();
        final lunarMonthInfo = LunarMonth.fromYm(
            Lunar.fromDate(DateTime.now()).getYear(),
            Lunar.fromDate(DateTime.now()).getMonth());
        final daysCount = lunarMonthInfo?.getDayCount() ?? 30;

        var lunarIcon = Icons.nightlight_outlined;
        var lunarIconColor = colorScheme.onSurface;

        if (lunarDay == 1) {
          // New Moon
          lunarIcon = Icons.circle_outlined;
          lunarIconColor = colorScheme.onSurface;
        } else if (lunarDay == 15) {
          // Full Moon
          lunarIcon = Icons.circle;
          lunarIconColor = Colors.orange;
        } else if (lunarDay > 1 && lunarDay < 8) {
          // Waxing Crescent
          lunarIcon = Icons.nightlight;
          lunarIconColor = Colors.orange;
        } else if (lunarDay >= 8 && lunarDay <= 14) {
          // Waxing Gibbous
          lunarIcon = Icons.brightness_3;
          lunarIconColor = Colors.orange;
        } else if (lunarDay > 15 && lunarDay < 22) {
          // Waning Gibbous
          lunarIcon = Icons.mode_night;
          lunarIconColor = Colors.orange;
        } else if (lunarDay >= 22 && lunarDay < daysCount) {
          // Waning Crescent
          lunarIcon = Icons.dark_mode;
          lunarIconColor = colorScheme.onSurface;
        } else if (lunarDay == daysCount) {
          // Last day of lunar month (could be a new moon)
          lunarIcon = Icons.circle_outlined;
          lunarIconColor = colorScheme.onSurface;
        }

        final horizontalPadding = isTablet
            ? AppConstants.tabletHorizontalPadding
            : AppConstants.mobileHorizontalPadding;
        final verticalPadding = isTablet
            ? AppConstants.tabletVerticalPadding
            : AppConstants.mobileVerticalPadding;

        if (useTwoColumnLayout) {
          // Two-column layout for tablets in landscape mode
          return BlocListener<HomeBloc, HomeState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == HomeStatus.error) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                        content: Text(state.error ?? 'Error loading favorite')),
                  );
              }
            },
            child: CustomScrollView(
              slivers: [
                SliverSafeArea(
                  sliver: SliverAppBar(
                    expandedHeight: AppConstants.tabletAppBarHeight,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      background: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              i10n.homeDate(DateTime.now()),
                              style: textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  '${DateTime.now().year + 544} BE',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Container(
                                  width: 1,
                                  height: 16,
                                  color: colorScheme.onSurface,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Lunar Day $lunarDay',
                                  style: textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  lunarIcon,
                                  color: lunarIconColor,
                                  size: AppConstants.tabletIconSize * 0.8,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        // Two-column layout for tablet in landscape
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Left column - Quote section
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    AppConstants.tabletCardPadding * 0.5),
                                child: Card(
                                  color: colorScheme.primaryContainer,
                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        AppConstants.tabletCardPadding),
                                    child: BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            HomeStatus.loading) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${state.todayQuote?.quote}',
                                              style: textTheme.headlineSmall
                                                  ?.copyWith(
                                                color: colorScheme
                                                    .onPrimaryContainer,
                                                height: 1.5,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                '"${state.todayQuote?.source}"',
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: colorScheme
                                                      .onPrimaryContainer,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                                width: AppConstants.tabletMediumSizedBoxHeight),
                            // Right column - Last read and favorites
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    AppConstants.tabletCardPadding * 0.5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      i10n.homeLastRead,
                                      style: textTheme.headlineSmall,
                                    ),
                                    SizedBox(
                                        height: AppConstants
                                            .tabletSmallSizedBoxHeight),
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            HomeStatus.loading) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (state.lastReadMenu == null) {
                                          return Center(
                                            child: Text(
                                                i10n.homeNoLastReadParitta),
                                          );
                                        }

                                        final menuItem = state.lastReadMenu!;

                                        return Card.outlined(
                                          elevation: 2,
                                          child: Padding(
                                            padding: EdgeInsets.all(
                                                AppConstants.tabletCardPadding *
                                                    0.5),
                                            child: InkWell(
                                              onTap: () => context.push(
                                                Uri(
                                                  path:
                                                      '/paritta/list/${menuItem.id}',
                                                  queryParameters: {
                                                    'title': menuItem.title
                                                  },
                                                ).toString(),
                                              ),
                                              child: ListTile(
                                                title: Text(
                                                  menuItem.title,
                                                  style: textTheme.titleLarge,
                                                ),
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  backgroundImage: AssetImage(
                                                      menuItem.image ?? ''),
                                                  radius: AppConstants
                                                      .tabletAvatarRadius,
                                                ),
                                                trailing: const Icon(
                                                    Icons.arrow_forward_ios),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(
                                        height: AppConstants
                                            .tabletMediumSizedBoxHeight),
                                    Text(
                                      i10n.homeFavorite,
                                      style: textTheme.headlineSmall,
                                    ),
                                    SizedBox(
                                        height: AppConstants
                                            .tabletSmallSizedBoxHeight),
                                    BlocBuilder<HomeBloc, HomeState>(
                                      builder: (context, state) {
                                        if (state.status ==
                                            HomeStatus.loading) {
                                          return const Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }

                                        if (state.favoriteMenus.isEmpty) {
                                          return Center(
                                              child: Text(
                                                  i10n.homeNoFavoriteParitta));
                                        }

                                        // List for favorites (same visual hierarchy as last read)
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              top: AppConstants
                                                      .tabletCardPadding *
                                                  0.5),
                                          child: Column(
                                            children: state.favoriteMenus
                                                .map((menuItem) {
                                              return Card.outlined(
                                                elevation: 2,
                                                child: Padding(
                                                  padding: EdgeInsets.all(
                                                      AppConstants
                                                              .tabletCardPadding *
                                                          0.5),
                                                  child: InkWell(
                                                    onTap: () => context.push(
                                                      Uri(
                                                        path:
                                                            '/paritta/list/${menuItem.id}',
                                                        queryParameters: {
                                                          'title':
                                                              menuItem.title
                                                        },
                                                      ).toString(),
                                                    ),
                                                    child: ListTile(
                                                      title: Text(
                                                        menuItem.title,
                                                        style: textTheme
                                                            .titleLarge,
                                                      ),
                                                      leading: CircleAvatar(
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            AssetImage(menuItem
                                                                    .image ??
                                                                'assets/images/tuntunan_puja_bhakti.png'),
                                                        radius: AppConstants
                                                            .tabletAvatarRadius,
                                                      ),
                                                      trailing: const Icon(Icons
                                                          .arrow_forward_ios),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        // Single column layout for phones and tablets in portrait mode
        return BlocListener<HomeBloc, HomeState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == HomeStatus.error) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                      content: Text(state.error ?? 'Error loading favorite')),
                );
            }
          },
          child: CustomScrollView(
            slivers: [
              SliverSafeArea(
                sliver: SliverAppBar(
                  expandedHeight: isTablet
                      ? AppConstants.tabletAppBarHeight
                      : AppConstants.mobileAppBarHeight,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            i10n.homeDate(DateTime.now()),
                            style: isTablet
                                ? textTheme.headlineMedium
                                : textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${DateTime.now().year + 544} BE',
                                style: (isTablet
                                        ? textTheme.titleMedium
                                        : textTheme.bodySmall)
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                width: 1,
                                height: 16,
                                color: colorScheme.onSurface,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Lunar Day $lunarDay',
                                style: (isTablet
                                        ? textTheme.titleMedium
                                        : textTheme.bodySmall)
                                    ?.copyWith(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Icon(
                                lunarIcon,
                                color: lunarIconColor,
                                size: isTablet
                                    ? AppConstants.tabletIconSize * 0.8
                                    : AppConstants.mobileIconSize * 0.8,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(horizontalPadding),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Card(
                        color: colorScheme.primaryContainer,
                        elevation: isTablet ? 2 : 1,
                        child: Padding(
                          padding: EdgeInsets.all(isTablet
                              ? AppConstants.tabletCardPadding
                              : AppConstants.mobileCardPadding),
                          child: BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              if (state.status == HomeStatus.loading) {
                                return const Center(
                                    child: CircularProgressIndicator());
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${state.todayQuote?.quote}',
                                    style: (isTablet
                                            ? textTheme.headlineSmall
                                            : textTheme.titleMedium)
                                        ?.copyWith(
                                      color: colorScheme.onPrimaryContainer,
                                      height: 1.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '"${state.todayQuote?.source}"',
                                      style: textTheme.bodyMedium?.copyWith(
                                        color: colorScheme.onPrimaryContainer,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                          height: isTablet
                              ? AppConstants.tabletLargeSizedBoxHeight
                              : AppConstants.mobileLargeSizedBoxHeight),
                      Row(
                        children: [
                          Text(
                            i10n.homeLastRead,
                            style: isTablet
                                ? textTheme.headlineSmall
                                : textTheme.titleMedium,
                          )
                        ],
                      ),
                      SizedBox(
                          height: isTablet
                              ? AppConstants.tabletSmallSizedBoxHeight
                              : AppConstants.mobileSmallSizedBoxHeight),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.status == HomeStatus.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (state.lastReadMenu == null) {
                            return Center(
                              child: Text(i10n.homeNoLastReadParitta),
                            );
                          }

                          final menuItem = state.lastReadMenu!;

                          return Card.outlined(
                            elevation: isTablet ? 2 : 1,
                            child: Padding(
                              padding: EdgeInsets.all(isTablet
                                  ? AppConstants.tabletCardPadding * 0.5
                                  : AppConstants.mobileCardPadding * 0.5),
                              child: InkWell(
                                onTap: () => context.push(
                                  Uri(
                                    path: '/paritta/list/${menuItem.id}',
                                    queryParameters: {'title': menuItem.title},
                                  ).toString(),
                                ),
                                child: ListTile(
                                  title: Text(
                                    menuItem.title,
                                    style: isTablet
                                        ? textTheme.titleLarge
                                        : textTheme.titleMedium,
                                  ),
                                  leading: CircleAvatar(
                                    backgroundColor: Colors.transparent,
                                    backgroundImage:
                                        AssetImage(menuItem.image ?? ''),
                                    radius: isTablet
                                        ? AppConstants.tabletAvatarRadius
                                        : AppConstants.mobileAvatarRadius,
                                  ),
                                  trailing: const Icon(Icons.arrow_forward_ios),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                          height: isTablet
                              ? AppConstants.tabletMediumSizedBoxHeight
                              : AppConstants.mobileMediumSizedBoxHeight),
                      Row(
                        children: [
                          Text(
                            i10n.homeFavorite,
                            style: isTablet
                                ? textTheme.headlineSmall
                                : textTheme.titleMedium,
                          )
                        ],
                      ),
                      SizedBox(
                          height: isTablet
                              ? AppConstants.tabletSmallSizedBoxHeight
                              : AppConstants.mobileSmallSizedBoxHeight),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state.status == HomeStatus.loading) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }

                          if (state.favoriteMenus.isEmpty) {
                            return Center(
                                child: Text(i10n.homeNoFavoriteParitta));
                          }

                          // List layout for favorites (same as last read)
                          return Column(
                            children: state.favoriteMenus
                                .map((menuItem) => Card.outlined(
                                      elevation: isTablet ? 2 : 1,
                                      child: Padding(
                                        padding: EdgeInsets.all(isTablet
                                            ? AppConstants.tabletCardPadding *
                                                0.5
                                            : AppConstants.mobileCardPadding *
                                                0.5),
                                        child: InkWell(
                                          onTap: () => context.push(
                                            Uri(
                                              path:
                                                  '/paritta/list/${menuItem.id}',
                                              queryParameters: {
                                                'title': menuItem.title
                                              },
                                            ).toString(),
                                          ),
                                          child: ListTile(
                                            title: Text(
                                              menuItem.title,
                                              style: isTablet
                                                  ? textTheme.titleLarge
                                                  : textTheme.titleMedium,
                                            ),
                                            leading: CircleAvatar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: AssetImage(menuItem
                                                      .image ??
                                                  'assets/images/tuntunan_puja_bhakti.png'),
                                              radius: isTablet
                                                  ? AppConstants
                                                      .tabletAvatarRadius
                                                  : AppConstants
                                                      .mobileAvatarRadius,
                                            ),
                                            trailing: const Icon(
                                                Icons.arrow_forward_ios),
                                          ),
                                        ),
                                      ),
                                    ))
                                .toList(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
