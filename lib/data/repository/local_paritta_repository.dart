import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/menu_service.dart';
import 'package:paritta_app/data/service/paritta_service.dart';
import 'package:paritta_app/domain/model/paritta.dart';
import 'package:paritta_app/domain/repository/paritta_repository.dart';

class LocalParittaRepository extends ParittaRepository {
  LocalParittaRepository(
      {required ParittaService parittaService,
      required MenuService menuService})
      : _parittaService = parittaService,
        _menuService = menuService;

  final ParittaService _parittaService;
  final MenuService _menuService;

  static final _log = Logger('LocalParittaRepository');

  @override
  Future<Paritta> getParittaByID(String id) async {
    try {
      final paritta = await _parittaService.getParittaByID(id);

      return Paritta(text: paritta.text);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<List<Paritta>> getParittasByMenuID(String menuID) async {
    try {
      final menus = await _menuService.getMenu('$menuID.json');

      final parittas = <Paritta>[];
      for (var i = 0; i < menus.menus.length; i++) {
        final paritta = await _parittaService.getParittaByID(menus.menus[i].id);
        parittas.add(Paritta(text: paritta.text));
      }

      return parittas;
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
