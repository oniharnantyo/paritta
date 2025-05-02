part of 'app_bloc.dart';

enum AppStatus { initial, loading, success, error }

final class AppState extends Equatable {
  const AppState({
    this.status = AppStatus.initial,
    this.error = '',
    this.appConfig,
  });

  final AppStatus status;
  final String? error;
  final AppConfig? appConfig;

  AppState copyWith({
    AppStatus? status,
    String? error,
    AppConfig? appConfig,
  }) {
    return AppState(
      status: status ?? this.status,
      error: error ?? this.error,
      appConfig: appConfig ?? this.appConfig,
    );
  }

  @override
  List<Object?> get props => [status, error, appConfig];
}
