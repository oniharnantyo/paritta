part of 'home_tab_cubit.dart';

enum HomeTab { home, paritta, guide }

final class HomeTabState extends Equatable {
  const HomeTabState({
    this.tab = HomeTab.home,
  });

  final HomeTab tab;

  @override
  List<Object> get props => [tab];
}
