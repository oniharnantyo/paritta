import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required MenuRepository menuRepository})
      : _menuRepository = menuRepository,
        super(const HomeState()) {
    on<FavoriteMenusRequested>(_onFavoriteMenusRequested);
    on<LastReadMenuRequested>(_onLastReadMenuRequested);
  }

  final MenuRepository _menuRepository;

  Future<void> _onFavoriteMenusRequested(
    FavoriteMenusRequested event,
    Emitter<HomeState> emit,
  ) async {
    try {
      final favoriteMenus = await _menuRepository.getFavoriteMenus();

      emit(state.copyWith(
        status: HomeStatus.success,
        favoriteMenus: favoriteMenus,
      ));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, error: error.toString()));
    }
  }

  Future<void> _onLastReadMenuRequested(
    LastReadMenuRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final lastReadMenu = await _menuRepository.getLastReadMenu();

      emit(state.copyWith(
        status: HomeStatus.success,
        lastReadMenu: lastReadMenu,
      ));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, error: error.toString()));
    }
  }
}
