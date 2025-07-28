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
      bottomNavigationBar: NavigationBar(
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
              context
                  .read<SettingBloc>()
                  .add(const SettingAppConfigRequested());
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
      ),
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
    final screenWidth = MediaQuery.of(context).size.width;

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

    // Determine if we're on a tablet (screen width > 600)
    final isTablet = screenWidth > 600;

    final horizontalPadding = isTablet
        ? AppConstants.tabletHorizontalPadding
        : AppConstants.mobileHorizontalPadding;
    final verticalPadding = isTablet
        ? AppConstants.tabletVerticalPadding
        : AppConstants.mobileVerticalPadding;

    return BlocListener<HomeBloc, HomeState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == HomeStatus.error) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error loading favorite')),
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
                      horizontal: horizontalPadding, vertical: verticalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        i10n.homeDate(DateTime.now()),
                        style: isTablet
                            ? textTheme.titleLarge
                            : textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            '${DateTime.now().year + 544} BE',
                            style: (isTablet
                                    ? textTheme.titleMedium
                                    : textTheme.bodyMedium)
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
                                    : textTheme.bodyMedium)
                                ?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            lunarIcon,
                            color: lunarIconColor,
                            size: isTablet
                                ? AppConstants.tabletIconSize
                                : AppConstants.mobileIconSize,
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
                    elevation: 1,
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
                                        ? textTheme.titleLarge
                                        : textTheme.titleMedium)
                                    ?.copyWith(
                                  color: colorScheme.onPrimaryContainer,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 12),
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
                            ? textTheme.titleLarge
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
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.lastReadMenu == null) {
                        return Center(
                          child: Text(i10n.homeNoLastReadParitta),
                        );
                      }

                      final menuItem = state.lastReadMenu!;

                      return Card.outlined(
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
                              style: isTablet ? textTheme.titleMedium : null,
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(menuItem.image ?? ''),
                              radius: isTablet
                                  ? AppConstants.tabletAvatarRadius
                                  : AppConstants.mobileAvatarRadius,
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios),
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
                            ? textTheme.titleLarge
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
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.favoriteMenus.isEmpty) {
                        return Center(child: Text(i10n.homeNoFavoriteParitta));
                      }

                      return Column(
                        children: state.favoriteMenus
                            .map((menuItem) => Card.outlined(
                                  child: InkWell(
                                    onTap: () => context.push(
                                      Uri(
                                        path: '/paritta/list/${menuItem.id}',
                                        queryParameters: {
                                          'title': menuItem.title
                                        },
                                      ).toString(),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                        menuItem.title,
                                        style: isTablet
                                            ? textTheme.titleMedium
                                            : null,
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(menuItem
                                                .image ??
                                            'assets/images/tuntunan_puja_bhakti.png'),
                                        radius: isTablet
                                            ? AppConstants.tabletAvatarRadius
                                            : AppConstants.mobileAvatarRadius,
                                      ),
                                      trailing:
                                          const Icon(Icons.arrow_forward_ios),
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
  }
}
