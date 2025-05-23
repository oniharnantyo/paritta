import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/model/quote.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';
import 'package:paritta_app/domain/repository/quote_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required MenuRepository menuRepository,
    required QuoteRepository quoteRepository,
  })  : _menuRepository = menuRepository,
        _quoteRepository = quoteRepository,
        super(const HomeState()) {
    on<FavoriteMenusRequested>(_onFavoriteMenusRequested);
    on<LastReadMenuRequested>(_onLastReadMenuRequested);
    on<TodayQuoteRequested>(_onTodayQuoteRequested);
  }

  final MenuRepository _menuRepository;
  final QuoteRepository _quoteRepository;

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

  Future<void> _onTodayQuoteRequested(
    TodayQuoteRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final todayQuote = await _quoteRepository.getTodayQuote();
      emit(state.copyWith(status: HomeStatus.success, todayQuote: todayQuote));
    } catch (error) {
      emit(state.copyWith(status: HomeStatus.error, error: error.toString()));
    }
  }
}
