import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_tab_state.dart';

class HomeTabCubit extends Cubit<HomeTabState> {
  HomeTabCubit() : super(const HomeTabState());

  void setTab(int index) {
    var tab = HomeTab.home;
    switch (index) {
      case 0:
        tab = HomeTab.home;
      case 1:
        tab = HomeTab.paritta;
      case 2:
        tab = HomeTab.guide;
      case 3:
        tab = HomeTab.setting;
    }
    emit(HomeTabState(tab: tab));
  }
}
