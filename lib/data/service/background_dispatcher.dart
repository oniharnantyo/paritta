import 'dart:ui';

import 'package:logging/logging.dart';
import 'package:lunar/calendar/LunarMonth.dart';
import 'package:lunar/calendar/Solar.dart';
import 'package:paritta_app/data/service/app_config_service.dart';
import 'package:paritta_app/data/service/notification_service.dart';
import 'package:paritta_app/ui/core/i18n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final log = Logger('callbackDispatcher');

    final solar = Solar.fromDate(DateTime.now());
    final lunar = solar.getLunar();
    final lunarDay = lunar.getDay();

    final lunarMonthInfo = LunarMonth.fromYm(lunar.getYear(), lunar.getMonth());
    final daysCount = lunarMonthInfo?.getDayCount();

    log.info('Lunar day: $lunarDay, Days count: $daysCount');

    // Fixed the condition: should show notification on day 14 OR on the last day of the month
    if (lunarDay != 14 && lunarDay != daysCount) {
      log.info(
          'Not showing notification: not day 14 and not last day of month');
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

      log.info('Lunar notification shown successfully');
      return Future.value(true);
    } catch (e) {
      log.severe('Error showing lunar notification: ${e.toString()}');
      return Future.value(false);
    }
  });
}
