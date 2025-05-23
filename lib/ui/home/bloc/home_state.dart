part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.error = '',
    this.favoriteMenus = const [],
    this.lastReadMenu,
    this.todayQuote,
  });

  final HomeStatus status;
  final String? error;
  final List<MenuItem> favoriteMenus;
  final MenuItem? lastReadMenu;
  final Quote? todayQuote;

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<MenuItem>? favoriteMenus,
    MenuItem? lastReadMenu,
    Quote? todayQuote,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      favoriteMenus: favoriteMenus ?? this.favoriteMenus,
      lastReadMenu: lastReadMenu ?? this.lastReadMenu,
      todayQuote: todayQuote ?? this.todayQuote,
    );
  }

  @override
  List<Object?> get props =>
      [status, error, favoriteMenus, lastReadMenu, todayQuote];
}
