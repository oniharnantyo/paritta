import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppConfigService {
  AppConfigService({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  final Logger _log = Logger('ReaderConfigService');

  Future<void> save(AppConfigModel appConfig) async {
    try {
      final appConfigJson = jsonEncode(appConfig);
      await sharedPreferences.setString('appConfig', appConfigJson);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<AppConfigModel> get() async {
    try {
      final appConfigJson = await sharedPreferences.getString('appConfig');
      if (appConfigJson == null) {
        return const AppConfigModel(theme: 'system', language: 'id');
      }

      final appConfig = AppConfigModel.fromJson(
          jsonDecode(appConfigJson!) as Map<String, dynamic>);

      return appConfig;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
