import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_autostart/flutter_autostart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/domain/repository/app_config_repository.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc({required AppConfigRepository appConfigRepository})
      : _appConfigRepository = appConfigRepository,
        super(const SettingState()) {
    on<SettingAppConfigRequested>(_onSettingAppConfigRequested);
    on<ThemeSaved>(_onThemeSaved);
    on<LanguageSaved>(_onLanguageSaved);
    on<NotificationUposathaReminderChanged>(
        _onNotificationUposathaReminderChanged);
  }

  final AppConfigRepository _appConfigRepository;
  static final FlutterAutostart _flutterAutostart = FlutterAutostart();

  Future<void> _onSettingAppConfigRequested(
    SettingAppConfigRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));
    try {
      final appConfig = await _appConfigRepository.get();

      emit(state.copyWith(
        status: SettingStatus.success,
        appConfig: appConfig,
      ));
    } catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    }
  }

  Future<void> _onThemeSaved(
    ThemeSaved event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));
    try {
      final appConfig = await _appConfigRepository.get();

      final _appConfig = AppConfig(
        theme: event.theme,
        language: appConfig.language,
        notificationUposathaReminder: appConfig.notificationUposathaReminder,
      );

      await _appConfigRepository.save(_appConfig);

      emit(
          state.copyWith(status: SettingStatus.success, appConfig: _appConfig));
    } catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    }
  }

  Future<void> _onLanguageSaved(
    LanguageSaved event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));
    try {
      final appConfig = await _appConfigRepository.get();

      final _appConfig = AppConfig(
        theme: appConfig.theme,
        language: event.language,
        notificationUposathaReminder: appConfig.notificationUposathaReminder,
      );

      await _appConfigRepository.save(_appConfig);

      emit(
          state.copyWith(status: SettingStatus.success, appConfig: _appConfig));
    } catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    }
  }

  Future<void> _onNotificationUposathaReminderChanged(
    NotificationUposathaReminderChanged event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));
    try {
      final isGranted = await FlutterLocalNotificationsPlugin()
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.requestNotificationsPermission();

      if (!isGranted!) {
        emit(state.copyWith(
          status: SettingStatus.error,
          error: 'notification permission is not granted',
        ));
        return;
      }

      if (Platform.isAndroid) {
        final androidInfo = await DeviceInfoPlugin().androidInfo;

        const supportedBrands = ['xiaomi'];

        if (supportedBrands.contains(androidInfo.brand.toLowerCase())) {
          print(androidInfo.brand.toLowerCase());
          final isAutoStartEnabled =
              await _flutterAutostart.checkIsAutoStartEnabled();

          if (!isAutoStartEnabled!) {
            await _flutterAutostart.showAutoStartPermissionSettings();
          }
        }
      }

      final appConfig = await _appConfigRepository.get();

      final _appConfig = AppConfig(
        theme: appConfig.theme,
        language: appConfig.language,
        notificationUposathaReminder: event.notificationUposathaReminder,
      );

      await _appConfigRepository.save(_appConfig);

      emit(
          state.copyWith(status: SettingStatus.success, appConfig: _appConfig));
    } on PlatformException catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    } catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    }
  }
}
