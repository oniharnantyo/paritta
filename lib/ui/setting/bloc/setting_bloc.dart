import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
  }

  final AppConfigRepository _appConfigRepository;

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

      final _appConfig =
          AppConfig(theme: event.theme, language: appConfig.language);

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
      );

      await _appConfigRepository.save(_appConfig);

      emit(
          state.copyWith(status: SettingStatus.success, appConfig: _appConfig));
    } catch (error) {
      emit(
          state.copyWith(status: SettingStatus.error, error: error.toString()));
    }
  }
}
