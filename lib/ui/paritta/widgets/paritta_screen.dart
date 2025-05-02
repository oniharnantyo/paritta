import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class ParittaScreen extends StatelessWidget {
  const ParittaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<ParittaBloc, ParittaState>(
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
      child: BlocBuilder<ParittaBloc, ParittaState>(
        builder: (context, state) {
          if (state.status == ParittaStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status != ParittaStatus.success) {
            return const SizedBox();
          }

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 150,
                flexibleSpace: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCollapsed =
                        constraints.maxHeight <= kToolbarHeight + 40;

                    return FlexibleSpaceBar(
                      title: isCollapsed ? const Text('Paritta') : null,
                      centerTitle: true,
                      background: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Paritta', style: textTheme.headlineMedium),
                          Padding(
                            padding: EdgeInsets.all(16),
                            child: SearchBar(
                              leading: Icon(Icons.search),
                              hintText: 'Cari paritta',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              ...state.menus.map(
                (menu) {
                  return SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: MultiSliver(
                      children: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 0),
                            child: Text(
                              menu.title ?? '',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ),
                        ),
                        SliverGrid(
                          delegate: SliverChildBuilderDelegate(
                              childCount: menu.menus.length, (context, index) {
                            final _menu = menu.menus[index];
                            return Card.outlined(
                              clipBehavior: Clip.hardEdge,
                              child: InkWell(
                                onTap: () {
                                  context
                                      .read<ParittaBloc>()
                                      .add(LastReadMenuSaved(_menu));
                                  context.push(
                                    Uri(
                                      path: '/paritta/list/${_menu.id}',
                                      queryParameters: {'title': _menu.title},
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
                                            aspectRatio: 4 / 3, // square image
                                            child: Image.asset(
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
                                                if (_menu.isFavorite ?? false) {
                                                  context
                                                      .read<ParittaBloc>()
                                                      .add(FavoriteMenuDeleted(
                                                          _menu.id));
                                                } else {
                                                  context
                                                      .read<ParittaBloc>()
                                                      .add(FavoriteMenuAdded(
                                                          _menu));
                                                }
                                              },
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 3,
                                                      vertical: 3),
                                              constraints: const BoxConstraints(
                                                  maxHeight: 24, maxWidth: 24),
                                              icon: const Icon(
                                                Icons.favorite_border,
                                                size: 18,
                                              ),
                                              isSelected: _menu.isFavorite,
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
                                        _menu.title ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            childAspectRatio: 5 / 6,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SliverFillRemaining(),
            ],
          );
        },
      ),
    );
  }
}
