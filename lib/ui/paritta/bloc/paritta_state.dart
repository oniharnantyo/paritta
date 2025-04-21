part of 'paritta_bloc.dart';

enum ParittaStatus { initial, loading, success, error }

final class ParittaState extends Equatable {
  const ParittaState({
    this.status = ParittaStatus.initial,
    this.error = '',
    this.menu,
    this.menus = const [],
    this.paritta,
    this.parittas = const [],
  });

  final ParittaStatus status;
  final String? error;
  final Menu? menu;
  final List<Menu> menus;
  final Paritta? paritta;
  final List<Paritta> parittas;

  ParittaState copyWith({
    ParittaStatus? status,
    String? error,
    Menu? menu,
    List<Menu>? menus,
    Paritta? paritta,
    List<Paritta>? parittas,
  }) {
    return ParittaState(
      status: status ?? this.status,
      error: error ?? this.error,
      menu: menu ?? this.menu,
      menus: menus ?? this.menus,
      paritta: paritta ?? this.paritta,
      parittas: parittas ?? this.parittas,
    );
  }

  @override
  List<Object?> get props => [status, error, menu, paritta];
}
