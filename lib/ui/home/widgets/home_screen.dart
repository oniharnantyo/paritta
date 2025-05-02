import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lunar/lunar.dart';
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: colorScheme.primary,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.inversePrimary,
        currentIndex: selectedTab.index,
        onTap: (index) {
          switch (index) {
            case 0:
              context.read<HomeBloc>()
                ..add(const FavoriteMenusRequested())
                ..add(const LastReadMenuRequested());
            case 1:
              context.read<ParittaBloc>().add(const MainMenuRequested());
            case 2:
              context
                  .read<SettingBloc>()
                  .add(const SettingAppConfigRequested());
          }
          context.read<HomeTabCubit>().setTab(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: i10n.homeNavbarTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: i10n.parittaNavbarTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: i10n.guideNavbarTitle,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
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
              expandedHeight: 80,
              pinned: true,
              flexibleSpace: FlexibleSpaceBar(
                background: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i10n.homeDate(DateTime.now()),
                          style: textTheme.titleMedium),
                      Row(
                        children: [
                          Text(
                            '${DateTime.now().year + 544} BE',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '-',
                            style: textTheme.titleSmall,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Lunar ${Lunar.fromDate(DateTime.now()).getDay()}',
                            style: textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.nightlight,
                            color: Colors.orange,
                            size: 16,
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
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    color: colorScheme.primaryContainer,
                    elevation: 1,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 6,
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '"Karaniyametta Sutta"',
                                  style: textTheme.bodySmall?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Tak bergaul dengan orang yang tak bijaksana\n'
                                  'Bergaul dengan mereka yang bijaksana\n'
                                  'Menghormat mereka yang patut dihormat\n'
                                  'Itulah Berkah Utama',
                                  style: textTheme.titleLarge?.copyWith(
                                    color: colorScheme.onPrimaryContainer,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text(
                        'Terakhir Dibaca',
                        style: textTheme.titleMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.status == HomeStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.lastReadMenu == null) {
                        return const Center(
                          child: Text('Belum ada paritta yang dibaca'),
                        );
                      }

                      final menuItem = state.lastReadMenu!;

                      return Card.outlined(
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(menuItem.title),
                              leading: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage(menuItem.image ?? ''),
                              ),
                              trailing: FilledButton(
                                  onPressed: () {}, child: const Text('Mulai')),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text(
                        'Favorit',
                        style: textTheme.titleMedium,
                      )
                    ],
                  ),
                  const SizedBox(height: 6),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.status == HomeStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.favoriteMenus.isEmpty) {
                        return const Center(
                            child: Text('Belum ada paritta favorit'));
                      }

                      return Column(
                        children: state.favoriteMenus
                            .map((menuItem) => Card.outlined(
                                  child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(menuItem.title),
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: AssetImage(menuItem
                                                  .image ??
                                              'assets/images/tuntunan_puja_bhakti.png'),
                                        ),
                                        trailing: FilledButton(
                                            onPressed: () => context.push(
                                                  Uri(
                                                    path:
                                                        '/paritta/list/${menuItem.id}',
                                                    queryParameters: {
                                                      'title': menuItem.title
                                                    },
                                                  ).toString(),
                                                ),
                                            child: const Text('Mulai')),
                                      )
                                    ],
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
          const SliverFillRemaining(),
        ],
      ),
    );
  }
}
