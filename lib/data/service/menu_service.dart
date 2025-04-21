import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/menu_model.dart';

class MenuService {
  static final _log = Logger('MenuService');

  Future<List<MenuModel>> getMainMenu() async {
    try {
      final data =
          await rootBundle.loadString('assets/json/menu/main_menu.json');
      final jsonList = jsonDecode(data) as List<dynamic>;

      return jsonList.map((json) {
        final _json = json as Map<String, dynamic>;
        return MenuModel.fromJson(_json);
      }).toList();
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<MenuModel> getMenu(String fileName) async {
    try {
      final data = await rootBundle.loadString('assets/json/menu/$fileName');
      final json = jsonDecode(data) as Map<String, dynamic>;

      return MenuModel.fromJson(json);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
