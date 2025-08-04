part of 'paritta_bloc.dart';

sealed class ParittaEvent extends Equatable {
  const ParittaEvent();

  @override
  List<Object?> get props => [];
}

final class MainMenuRequested extends ParittaEvent {
  const MainMenuRequested({this.search});

  final String? search;

  @override
  List<Object?> get props => [search];
}

final class CategoryTitlesRequested extends ParittaEvent {
  const CategoryTitlesRequested();

  @override
  List<Object?> get props => [];
}

final class FavoriteMenuAdded extends ParittaEvent {
  const FavoriteMenuAdded(this.menuItem);

  final MenuItem menuItem;

  @override
  List<Object> get props => [menuItem];
}

final class FavoriteMenuDeleted extends ParittaEvent {
  const FavoriteMenuDeleted(this.menuItemId);

  final String menuItemId;

  @override
  List<Object> get props => [menuItemId];
}

final class LastReadMenuSaved extends ParittaEvent {
  const LastReadMenuSaved(this.menuItem);

  final MenuItem menuItem;

  @override
  List<Object> get props => [menuItem];
}

final class ParittaMenuRequested extends ParittaEvent {
  const ParittaMenuRequested(this.menuId);

  final String menuId;

  @override
  List<Object> get props => [menuId];
}

final class ParittaRequested extends ParittaEvent {
  const ParittaRequested(this.parittaId);

  final String parittaId;

  @override
  List<Object> get props => [parittaId];
}

final class ParittasRequested extends ParittaEvent {
  const ParittasRequested(this.menuId);

  final String menuId;

  @override
  List<Object> get props => [menuId];
}
