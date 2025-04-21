import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/menu_service.dart';
import 'package:paritta_app/domain/model/menu.dart';
import 'package:paritta_app/domain/repository/menu_repository.dart';

class LocalMenuRepository extends MenuRepository {
  LocalMenuRepository({required MenuService menuService})
      : _menuService = menuService;

  final MenuService _menuService;

  static final _log = Logger('LocalMenuRepository');

  @override
  Future<List<Menu>> getMainMenus() async {
    try {
      final menus = await _menuService.getMainMenu();

      return menus
          .map(
            (menu) => Menu(
              title: menu.title,
              menus: menu.menus
                  .map((_menu) => MenuItem(
                        id: _menu.id,
                        title: _menu.title,
                        description: _menu.description,
                      ))
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
                ))
            .toList(),
      );
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
