import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/app_config_service.dart';
import 'package:paritta_app/data/service/model/app_config.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/domain/repository/app_config_repository.dart';

class LocalAppConfigRepository extends AppConfigRepository {
  LocalAppConfigRepository({required AppConfigService appConfigService})
      : _appConfigService = appConfigService;

  final AppConfigService _appConfigService;

  static final _log = Logger('LocalAppConfigRepository');

  @override
  Future<AppConfig> get() async {
    try {
      final appConfig = await _appConfigService.get();
      return AppConfig(
        theme: themeFromString(appConfig.theme),
        language: languageFromString(appConfig.language),
      );
    } catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<void> save(AppConfig appConfig) async {
    try {
      final appConfigModel = AppConfigModel(
        theme: appConfig.theme.name,
        language: appConfig.language.name,
      );

      print('app config repo ${appConfig}');
      
      await _appConfigService.save(appConfigModel);
    } catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  ThemeMode themeFromString(String theme) {
    switch (theme) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Language languageFromString(String language) {
    switch (language) {
      case 'en':
        return Language.en;
      default:
        return Language.id;
    }
  }
}
