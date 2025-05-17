part of 'setting_bloc.dart';

enum SettingStatus { initial, loading, success, error }

final class SettingState extends Equatable {
  const SettingState(
      {this.status = SettingStatus.initial, this.error = '', this.appConfig});

  final SettingStatus status;
  final String? error;
  final AppConfig? appConfig;

  SettingState copyWith({
    SettingStatus? status,
    String? error,
    AppConfig? appConfig,
  }) {
    return SettingState(
      status: status ?? this.status,
      error: error ?? this.error,
      appConfig: appConfig ?? this.appConfig,
    );
  }

  @override
  List<Object?> get props => [status, error, appConfig];
}
