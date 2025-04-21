import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(int index) {
    var tab = HomeTab.home;
    switch (index) {
      case 0:
        tab = HomeTab.home;
      case 1:
        tab = HomeTab.paritta;
      case 2:
        tab = HomeTab.guide;
    }
    emit(HomeState(tab: tab));
  }
}
