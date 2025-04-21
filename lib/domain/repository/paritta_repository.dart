import 'package:paritta_app/domain/model/paritta.dart';

abstract class ParittaRepository {
  Future<Paritta> getParittaByID(String id);

  Future<List<Paritta>> getParittasByMenuID(String menuID);
}
