import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/model/paritta.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';
import 'package:paritta_app/domain/repository/paritta_repository.dart';

part 'paritta_event.dart';
part 'paritta_state.dart';

class ParittaBloc extends Bloc<ParittaEvent, ParittaState> {
  ParittaBloc({
    required ParittaRepository parittaRepository,
    required MenuRepository menuRepository,
  })  : _parittaRepository = parittaRepository,
        _menuRepository = menuRepository,
        super(const ParittaState()) {
    on<MainMenuRequested>(_onMainMenuRequested);
    on<ParittaMenuRequested>(_onParittaMenuRequested);
    on<ParittaRequested>(_onParittaRequested);
    on<ParittasRequested>(_onParittasRequested);
  }

  final ParittaRepository _parittaRepository;
  final MenuRepository _menuRepository;

  Future<void> _onMainMenuRequested(
    MainMenuRequested event,
    Emitter<ParittaState> emit,
  ) async {
    emit(state.copyWith(status: ParittaStatus.loading));
    try {
      final menus = await _menuRepository.getMainMenus();
      emit(state.copyWith(status: ParittaStatus.success, menus: menus));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onParittaMenuRequested(
    ParittaMenuRequested event,
    Emitter<ParittaState> emit,
  ) async {
    emit(state.copyWith(status: ParittaStatus.loading));
    try {
      final menu = await _menuRepository.getMenusByID(event.menuId);
      emit(state.copyWith(status: ParittaStatus.success, menu: menu));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onParittaRequested(
    ParittaRequested event,
    Emitter<ParittaState> emit,
  ) async {
    emit(state.copyWith(status: ParittaStatus.loading));
    try {
      final paritta = await _parittaRepository.getParittaByID(event.parittaId);
      emit(state.copyWith(status: ParittaStatus.success, paritta: paritta));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onParittasRequested(
    ParittasRequested event,
    Emitter<ParittaState> emit,
  ) async {
    emit(state.copyWith(status: ParittaStatus.loading));
    try {
      final parittas =
          await _parittaRepository.getParittasByMenuID(event.menuId);
      emit(state.copyWith(status: ParittaStatus.success, parittas: parittas));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaStatus.error,
          error: error.toString(),
        ),
      );
    }
  }
}
