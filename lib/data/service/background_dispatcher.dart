import 'dart:ui';

import 'package:logging/logging.dart';
import 'package:lunar/calendar/Lunar.dart';
import 'package:paritta_app/data/service/app_config_service.dart';
import 'package:paritta_app/data/service/notification_service.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final log = Logger('callbackDispatcher');

    final lunarDay = Lunar.fromDate(DateTime.now()).getDay();

    if (lunarDay != 1 && lunarDay != 15) {
      return Future.value(false);
    }

    final sharedPreferences = SharedPreferencesAsync();
    final appConfigService =
        AppConfigService(sharedPreferences: sharedPreferences);

    final notificationService =
        NotificationService(appConfigService: appConfigService);

    try {
      final appConfig = await appConfigService.get();

      final language = appConfig.language;

      final i10n = await AppLocalizations.delegate.load(Locale(language));

      await notificationService.init();
      await notificationService.showLunarNotification(
          i10n.notificationUposatha, i10n.notificationUposathaDescription);

      return Future.value(true);
    } catch (e) {
      log.severe(e.toString());
      return Future.value(false);
    }
  });
}
