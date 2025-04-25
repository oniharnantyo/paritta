import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/paritta_model.dart';

class ParittaService {
  ParittaService();

  final Logger _log = Logger('ParittaService');

  Future<ParittaModel> getParittaByID(String id) async {
    try {
      final data =
          await rootBundle.loadString('assets/markdown/paritta/$id.md');

      return ParittaModel(text: data);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
