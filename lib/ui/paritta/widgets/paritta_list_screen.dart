import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';

class ParittaListScreen extends StatelessWidget {
  const ParittaListScreen({required this.menuId, super.key});

  final String menuId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ParittaBloc, ParittaState>(
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
                  expandedHeight: 100,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => context.pop(),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(state.menu?.title ?? ''),
                    expandedTitleScale: 1,
                    centerTitle: true,
                  ),
                ),
                if (state.menu?.menus.isNotEmpty ?? false)
                  SliverPadding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    sliver: SliverList.separated(
                      separatorBuilder: (_, __) => const Divider(),
                      itemCount: state.menu?.menus.length,
                      itemBuilder: (_, index) {
                        final menu = state.menu?.menus[index];
                        return ListTile(
                          title: Text(menu!.title),
                          subtitle: Text(menu.description ?? ''),
                          onTap: () => context.push(
                            Uri(
                              path: '/paritta/list/$menuId/reader',
                              queryParameters: {
                                'initialPage': index.toString()
                              },
                            ).toString(),
                          ),
                        );
                      },
                    ),
                  )
                else
                  const SliverToBoxAdapter(),
                const SliverFillRemaining()
              ],
            );
          },
        ),
      ),
    );
  }
}
