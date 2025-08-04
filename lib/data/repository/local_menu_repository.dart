import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/menu_service.dart';
import 'package:paritta_app/data/service/model/menu_model.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';

class LocalMenuRepository extends MenuRepository {
  LocalMenuRepository({required MenuService menuService})
      : _menuService = menuService;

  final MenuService _menuService;

  static final _log = Logger('LocalMenuRepository');

  @override
  Future<List<Menu>> getMainMenus({String? search}) async {
    try {
      final menus = await _menuService.getMainMenu(search);

      return menus
          .map(
            (menu) => Menu(
              title: menu.title,
              menus: menu.menus
                  .map(
                    (_menu) => MenuItem(
                      id: _menu.id,
                      title: _menu.title,
                      description: _menu.description,
                      image: _menu.image,
                      isFavorite: _menu.isFavorite,
                    ),
                  )
                  .toList(),
            ),
          )
          .toList();
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<List<String>> getCategoryTitles() async {
    try {
      final menus = await _menuService.getMainMenu(null);
      return menus.map((menu) => menu.title).toList();
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<Menu> getMenusByID(String id) async {
    try {
      final menus = await _menuService.getMenu('$id.json');

      return Menu(
        title: menus.title,
        menus: menus.menus
            .map((menu) => MenuItem(
                  id: menu.id,
                  title: menu.title,
                  description: menu.description,
                  image: menu.image,
                  isFavorite: menu.isFavorite,
                ))
            .toList(),
      );
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<List<MenuItem>> getFavoriteMenus() async {
    try {
      final favoriteMenus = await _menuService.getFavoriteMenus();
      return favoriteMenus
          .map((menu) => MenuItem(
                id: menu.id,
                title: menu.title,
                description: menu.description,
                image: menu.image,
                isFavorite: menu.isFavorite,
              ))
          .toList();
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<void> addFavoriteMenu(MenuItem favoriteMenu) async {
    try {
      final _favoriteMenu = MenuItemModel(
        id: favoriteMenu.id,
        title: favoriteMenu.title,
        description: favoriteMenu.description,
        image: favoriteMenu.image,
        isFavorite: true,
      );
      await _menuService.addFavoriteMenu(_favoriteMenu);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<void> deleteFavoriteMenu(String menuItemId) async {
    try {
      await _menuService.deleteFavoriteMenu(menuItemId);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<void> saveLastReadMenu(MenuItem menuItem) async {
    try {
      final _menuItem = MenuItemModel(
        id: menuItem.id,
        title: menuItem.title,
        description: menuItem.description,
        image: menuItem.image,
        isFavorite: menuItem.isFavorite,
      );
      await _menuService.saveLastReadMenu(_menuItem);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<MenuItem> getLastReadMenu() async {
    try {
      final menuItem = await _menuService.getLastReadMenu();

      return MenuItem(
        id: menuItem.id,
        title: menuItem.title,
        description: menuItem.description,
        image: menuItem.image,
        isFavorite: menuItem.isFavorite,
      );
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
