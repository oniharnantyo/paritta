part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

final class FavoriteMenusRequested extends HomeEvent {
  const FavoriteMenusRequested();
}

final class LastReadMenuRequested extends HomeEvent {
  const LastReadMenuRequested();
}
