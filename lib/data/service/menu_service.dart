import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuService {
  MenuService({required this.sharedPreferences});

  final SharedPreferencesAsync sharedPreferences;

  static final _log = Logger('MenuService');

  Future<List<MenuModel>> getMainMenu(String? search) async {
    try {
      final data =
          await rootBundle.loadString('assets/json/menu/main_menu.json');
      final menuJson = jsonDecode(data) as List<dynamic>;

      final menus = menuJson
          .map((_menuJson) =>
              MenuModel.fromJson(_menuJson as Map<String, dynamic>))
          .toList();

      final favoriteMenusJson =
          await sharedPreferences.getString('favoriteMenus');

      // Initialize favoriteMenus as empty map if null
      var favoriteMenus = <String, dynamic>{};
      if (favoriteMenusJson != null) {
        favoriteMenus = jsonDecode(favoriteMenusJson) as Map<String, dynamic>;
      }

      var result = <MenuModel>[];

      for (var i = 0; i < menus.length; i++) {
        var menuItems = <MenuItemModel>[];
        for (var j = 0; j < menus[i].menus.length; j++) {
          final menuItem = menus[i].menus[j];

          // Apply search filter if provided
          if (search != null &&
              !menuItem.title.toLowerCase().contains(search.toLowerCase())) {
            continue;
          }

          menuItems.add(
            menus[i].menus[j].copyWith(
                  isFavorite: favoriteMenus.containsKey(menuItem.id),
                ),
          );
        }

        if (menuItems.isNotEmpty) {
          result.add(menus[i].copyWith(menus: menuItems));
        }
      }

      return result;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<MenuModel> getMenu(String fileName) async {
    try {
      final menuData =
          await rootBundle.loadString('assets/json/menu/$fileName');
      final menuDataJson = jsonDecode(menuData) as Map<String, dynamic>;

      final menuModel = MenuModel.fromJson(menuDataJson);

      return menuModel;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<List<MenuItemModel>> getFavoriteMenus() async {
    try {
      final favoriteMenusJson =
          await sharedPreferences.getString('favoriteMenus');
      var favoriteMenusMap = <String, dynamic>{};
      if (favoriteMenusJson != null) {
        favoriteMenusMap =
            jsonDecode(favoriteMenusJson) as Map<String, dynamic>;
      }
      final favoriteMenus = <MenuItemModel>[];
      favoriteMenusMap.forEach((key, value) {
        final menuItemModel = MenuItemModel.fromJson(
            jsonDecode(value as String) as Map<String, dynamic>);
        favoriteMenus.add(menuItemModel);
      });
      return favoriteMenus;
    } catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<void> addFavoriteMenu(MenuItemModel favoriteMenu) async {
    try {
      var favoriteMenusJson =
          await sharedPreferences.getString('favoriteMenus');

      _log.info(favoriteMenusJson);
      var favoriteMenus = <String, dynamic>{};
      if (favoriteMenusJson != null) {
        favoriteMenus = jsonDecode(favoriteMenusJson) as Map<String, dynamic>;
      }

      favoriteMenus
          .addAll(<String, dynamic>{favoriteMenu.id: jsonEncode(favoriteMenu)});

      favoriteMenusJson = jsonEncode(favoriteMenus);
      await sharedPreferences.setString('favoriteMenus', favoriteMenusJson);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<void> deleteFavoriteMenu(String menuItemId) async {
    try {
      var favoriteMenusJson =
          await sharedPreferences.getString('favoriteMenus');

      var favoriteMenus = <String, dynamic>{};
      if (favoriteMenusJson != null) {
        favoriteMenus = jsonDecode(favoriteMenusJson) as Map<String, dynamic>;
      }

      favoriteMenus.remove(menuItemId);

      favoriteMenusJson = jsonEncode(favoriteMenus);
      await sharedPreferences.setString('favoriteMenus', favoriteMenusJson);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<void> saveLastReadMenu(MenuItemModel menuItem) async {
    try {
      final lastReadMenuJson = jsonEncode(menuItem);
      await sharedPreferences.setString('lastReadMenu', lastReadMenuJson);
    } catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  Future<MenuItemModel> getLastReadMenu() async {
    try {
      final lastReadMenuJson =
          await sharedPreferences.getString('lastReadMenu');
      final menuItemModel = MenuItemModel.fromJson(
          jsonDecode(lastReadMenuJson!) as Map<String, dynamic>);

      return menuItemModel;
    } catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
