import 'package:paritta_app/domain/model/menu.dart';

abstract class MenuRepository {
  Future<List<Menu>> getMainMenus();

  Future<Menu> getMenusByID(String id);

  Future<List<MenuItem>> getFavoriteMenus();

  Future<void> addFavoriteMenu(MenuItem favoriteMenu);

  Future<void> deleteFavoriteMenu(String menuItemId);

  Future<void> saveLastReadMenu(MenuItem menuItem);

  Future<MenuItem> getLastReadMenu();
}
