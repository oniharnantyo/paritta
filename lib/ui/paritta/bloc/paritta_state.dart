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
    this.categoryTitles = const [],
  });

  final ParittaStatus status;
  final String? error;
  final Menu? menu;
  final List<Menu> menus;
  final Paritta? paritta;
  final List<Paritta> parittas;
  final List<String> categoryTitles;

  ParittaState copyWith({
    ParittaStatus? status,
    String? error,
    Menu? menu,
    List<Menu>? menus,
    Paritta? paritta,
    List<Paritta>? parittas,
    List<String>? categoryTitles,
  }) {
    return ParittaState(
      status: status ?? this.status,
      error: error ?? this.error,
      menu: menu ?? this.menu,
      menus: menus ?? this.menus,
      paritta: paritta ?? this.paritta,
      parittas: parittas ?? this.parittas,
      categoryTitles: categoryTitles ?? this.categoryTitles,
    );
  }

  @override
  List<Object?> get props => [status, error, menu, paritta, categoryTitles];
}
