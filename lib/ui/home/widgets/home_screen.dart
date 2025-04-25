import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:paritta_app/ui/home/cubit/home_bloc.dart';
import 'package:paritta_app/ui/home/cubit/home_tab_cubit.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeTabCubit cubit) => cubit.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [HomePage(), ParittaScreen()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTab.index,
        onTap: (index) {
          switch (index) {
            case 0:
              context.read<HomeBloc>()
                ..add(const FavoriteMenusRequested())
                ..add(const LastReadMenuRequested());
            case 1:
              context.read<ParittaBloc>().add(const MainMenuRequested());
          }
          context.read<HomeTabCubit>().setTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Paritta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_outlined),
            label: 'Panduan',
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
                      Text(
                        DateFormat.yMMMMEEEEd('id').format(DateTime.now()),
                        style: textTheme.titleMedium,
                      ),
                      Row(
                        children: [
                          Text(
                            '${DateTime.now().year + 544} BE',
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '-',
                            style: textTheme.titleSmall,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Lunar ${Lunar.fromDate(DateTime.now()).getDay()}',
                            style: textTheme.titleSmall
                                ?.copyWith(fontWeight: FontWeight.w400),
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
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.settings),
                )
              ],
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Card(
                    child: Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage(
                            'assets/images/quote_background.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    '"Karaniyametta Sutta"',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'Tak bergaul dengan orang yang tak bijaksana\n'
                                    'Bergaul dengan mereka yang bijaksana\n'
                                    'Menghormat mereka yang patut dihormat\n'
                                    'Itulah Berkah Utama',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(child: Container()),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Terakhir Dibaca',
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state.status == HomeStatus.loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      if (state.lastReadMenu == null) {
                        return Center(
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Favorit',
                        style: textTheme.titleLarge,
                      )
                    ],
                  ),
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

                      return SliverList.builder(itemBuilder: (context, index) {
                        final menuItem = state.favoriteMenus[index];

                        return Card.outlined(
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(menuItem.title),
                                leading: CircleAvatar(
                                  backgroundColor: Colors.transparent,
                                  backgroundImage: AssetImage(menuItem.image ??
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
                        );
                      });
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
