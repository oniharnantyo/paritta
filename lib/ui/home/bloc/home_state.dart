part of 'home_bloc.dart';

enum HomeStatus { initial, loading, success, error }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.error = '',
    this.favoriteMenus = const [],
    this.lastReadMenu,
  });

  final HomeStatus status;
  final String? error;
  final List<MenuItem> favoriteMenus;
  final MenuItem? lastReadMenu;

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    List<MenuItem>? favoriteMenus,
    MenuItem? lastReadMenu,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      favoriteMenus: favoriteMenus ?? this.favoriteMenus,
      lastReadMenu: lastReadMenu ?? this.lastReadMenu,
    );
  }

  @override
  List<Object?> get props => [status, error, favoriteMenus, lastReadMenu];
}
