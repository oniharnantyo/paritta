import 'dart:async';
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paritta_app/data/repository/local_menu_repository.dart';
import 'package:paritta_app/data/repository/local_paritta_repository.dart';
import 'package:paritta_app/data/repository/local_reader_config_repository.dart';
import 'package:paritta_app/data/service/menu_service.dart';
import 'package:paritta_app/data/service/paritta_service.dart';
import 'package:paritta_app/data/service/reader_config_service.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';
import 'package:paritta_app/domain/repository/paritta_repository.dart';
import 'package:paritta_app/domain/repository/reader_config_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> bootstrap(FutureOr<Widget> Function() builder) async {
  FlutterError.onError = (details) {
    log(details.exceptionAsString(), stackTrace: details.stack);
  };

  // Add cross-flavor configuration here

  final menuService = MenuService(sharedPreferences: SharedPreferencesAsync());

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<MenuRepository>(
          create: (context) => LocalMenuRepository(
            menuService: menuService,
          ),
        ),
        RepositoryProvider<ParittaRepository>(
          create: (context) => LocalParittaRepository(
            parittaService: ParittaService(),
            menuService: menuService,
          ),
        ),
        RepositoryProvider<ReaderConfigRepository>(
          create: (context) => LocalReaderConfigRepository(
            readerConfigService: ReaderConfigService(
                sharedPreferences: SharedPreferencesAsync()),
          ),
        ),
      ],
      child: await builder(),
    ),
  );
}
