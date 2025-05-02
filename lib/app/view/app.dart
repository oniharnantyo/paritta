import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:paritta_app/app/cubit/app_cubit.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/routing/router.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:paritta_app/ui/core/theme/theme.dart';
import 'package:paritta_app/ui/core/theme/util.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _router = router();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme =
        createTextTheme(context, 'Source Sans 3', 'Playfair Display');
    final theme = MaterialTheme(textTheme);

    return BlocBuilder<AppCubit, AppState>(
      builder: (context, state) {
        if (state.status == AppStatus.error) {
          return Scaffold(
            body: Center(
              child: Text(state.error ?? 'Error loading app'),
            ),
          );
        }

        if (state.appConfig == null) {
          return const SizedBox.shrink();
        }

        var _language = '';
        switch (state.appConfig!.language) {
          case Language.en:
            _language = 'en';
          case Language.id:
            _language = 'id';
        }

        return MaterialApp.router(
          themeMode: state.appConfig!.theme,
          theme: theme.lightHighContrast(),
          darkTheme: theme.darkHighContrast(),
          locale: Locale(_language),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: _router,
        );
      },
    );
  }
}
