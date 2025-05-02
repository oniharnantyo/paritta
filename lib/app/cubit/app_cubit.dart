import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/domain/repository/app_config_repository.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({required AppConfigRepository appConfigRepostory})
      : _appConfigRepository = appConfigRepostory,
        super(const AppState());

  final AppConfigRepository _appConfigRepository;

  Future<void> getAppConfig() async {
    try {
      final appConfig = await _appConfigRepository.get();
      emit(state.copyWith(status: AppStatus.success, appConfig: appConfig));
    } catch (error) {
      emit(state.copyWith(status: AppStatus.error, error: error.toString()));
    }
  }

  void updateAppConfig(AppConfig appConfig) {
    emit(state.copyWith(
      status: AppStatus.success,
      error: '',
      appConfig: appConfig,
    ));
  }
}
