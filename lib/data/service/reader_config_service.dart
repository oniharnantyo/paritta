import 'dart:convert';

import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/reader_config_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReaderConfigService {
  ReaderConfigService({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  final Logger _log = Logger('ReaderConfigService');

  Future<void> save(ReaderConfigModel readerConfig) async {
    try {
      final readerConfigJson = jsonEncode(readerConfig);
      await sharedPreferences.setString('readerConfig', readerConfigJson);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<ReaderConfigModel> get() async {
    try {
      final readerConfigJson =
          await sharedPreferences.getString('readerConfig');
      final readerConfig = ReaderConfigModel.fromJson(
          jsonDecode(readerConfigJson!) as Map<String, dynamic>);

      return readerConfig;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
