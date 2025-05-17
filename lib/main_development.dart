import 'package:flutter/material.dart';
import 'package:paritta_app/app/app.dart';
import 'package:paritta_app/bootstrap.dart';
import 'package:paritta_app/data/service/background_dispatcher.dart';
import 'package:workmanager/workmanager.dart';

@pragma('vm:entry-point')
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);
  Workmanager().registerPeriodicTask(
    'uposathaNotification',
    'Uposatha Notification',
    frequency: const Duration(minutes: 15),
  );
  bootstrap(() => const App());
}
