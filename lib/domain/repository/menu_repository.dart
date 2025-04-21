import 'package:paritta_app/domain/model/menu.dart';

abstract class MenuRepository {
  Future<List<Menu>> getMainMenus();

  Future<Menu> getMenusByID(String id);
}
