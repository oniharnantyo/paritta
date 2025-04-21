import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';
import 'package:paritta_app/domain/repository/paritta_repository.dart';
import 'package:paritta_app/domain/repository/reader_config_repository.dart';
import 'package:paritta_app/routing/routes.dart';
import 'package:paritta_app/ui/home/cubit/home_cubit.dart';
import 'package:paritta_app/ui/home/widgets/home_screen.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_bloc.dart';
import 'package:paritta_app/ui/paritta/bloc/paritta_reader_bloc.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_list_screen.dart';
import 'package:paritta_app/ui/paritta/widgets/paritta_reader_wrapper_screen.dart';

GoRouter router() {
  return GoRouter(
    initialLocation: Routes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: Routes.home,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<ParittaBloc>(
                create: (context) => ParittaBloc(
                  parittaRepository: context.read<ParittaRepository>(),
                  menuRepository: context.read<MenuRepository>(),
                ),
              ),
              BlocProvider(create: (context) => HomeCubit()),
            ],
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: Routes.parittaList,
        builder: (context, state) {
          final menuId = state.pathParameters['menuId']!;

          return BlocProvider(
            create: (context) => ParittaBloc(
              parittaRepository: context.read<ParittaRepository>(),
              menuRepository: context.read<MenuRepository>(),
            )..add(ParittaMenuRequested(menuId)),
            child: ParittaListScreen(
              menuId: menuId,
            ),
          );
        },
      ),
      GoRoute(
        path: Routes.parittaListReader,
        builder: (context, state) {
          final menuId = state.pathParameters['menuId']!;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ParittaBloc(
                  parittaRepository: context.read<ParittaRepository>(),
                  menuRepository: context.read<MenuRepository>(),
                )
                  ..add(ParittaMenuRequested(menuId))
                  ..add(ParittasRequested(menuId)),
              ),
              BlocProvider(
                create: (context) => ParittaReaderBloc(
                  readerConfigRepository:
                      context.read<ReaderConfigRepository>(),
                )..add(const ParittaReaderConfigRequested()),
              ),
            ],
            child: ParittaReaderWrapperScreen(
              initialPage:
                  int.tryParse(state.uri.queryParameters['initialPage']!) ?? 0,
            ),
          );
        },
      ),
    ],
  );
}
