import 'package:paritta_app/domain/model/app_config.dart';

abstract class AppConfigRepository {
  Future<void> save(AppConfig appConfig);

  Future<AppConfig> get();
}
