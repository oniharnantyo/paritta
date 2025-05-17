import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paritta_app/data/service/app_config_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  NotificationService({required this.appConfigService});

  late final FlutterLocalNotificationsPlugin _notifications;

  final AppConfigService appConfigService;

  Future<void> init() async {
    _notifications = FlutterLocalNotificationsPlugin();

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: ios);

    await _notifications.initialize(settings);

    tz.initializeTimeZones();
  }

  Future<void> showLunarNotification(String title, String body) async {
    await _notifications.show(
      1,
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'uposatha_channel',
          'Uposatha Reminders',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(),
      ),
    );
  }
}
