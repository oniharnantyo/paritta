import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/app_config.dart';
import 'package:paritta_app/domain/repository/app_config_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({required AppConfigRepository appConfigRepository})
      : _appConfigRepository = appConfigRepository,
        super(const AppState()) {
    on<AppConfigRequested>(_onAppConfigRequested);
  }

  final AppConfigRepository _appConfigRepository;

  Future<void> _onAppConfigRequested(
    AppConfigRequested event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.loading));
    try {
      final appConfig = await _appConfigRepository.get();

      emit(state.copyWith(status: AppStatus.success, appConfig: appConfig));
    } catch (error) {
      emit(state.copyWith(status: AppStatus.error, error: error.toString()));
    }
  }
}
