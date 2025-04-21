part of 'paritta_bloc.dart';

sealed class ParittaEvent extends Equatable {
  const ParittaEvent();

  @override
  List<Object> get props => [];
}

final class MainMenuRequested extends ParittaEvent {
  const MainMenuRequested();
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
