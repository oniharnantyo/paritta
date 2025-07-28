import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/ui/core/app_constants.dart';
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
                  expandedHeight: AppConstants.mobileAppBarHeight,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.mobileHorizontalPadding,
                        vertical: AppConstants.mobileVerticalPadding),
                    sliver: SliverList.separated(
                      separatorBuilder: (_, __) => const SizedBox(height: 16),
                      itemCount: state.menu?.menus.length,
                      itemBuilder: (_, index) {
                        final menu = state.menu?.menus[index];
                        return ListTile(
                          title: Text(
                            menu?.title ?? '',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          subtitle: Text(
                            menu?.description ?? '',
                            style: const TextStyle(
                              height: 1.2,
                            ),
                          ),
                          trailing: const Icon(Icons.chevron_right),
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
