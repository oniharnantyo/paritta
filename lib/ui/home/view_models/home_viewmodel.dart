import 'package:flutter/foundation.dart';
import 'package:paritta_app/utils/command.dart';
import 'package:paritta_app/utils/result.dart';

class HomeViewModel extends ChangeNotifier {
  HomeViewModel() {
    setSelectedPage = Command1<void, int>(_setSelectedPage);
  }

  int get selectedPage => _selectedPage;

  int _selectedPage = 0;

  late Command1<void, int> setSelectedPage;

  Future<Result<void>> _setSelectedPage(int index) async {
    print(index);
    try {
      _selectedPage = index;
      return const Result.ok(null);
    } finally {
      notifyListeners();
    }
  }
}
