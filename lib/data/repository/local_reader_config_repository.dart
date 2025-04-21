import 'package:logging/logging.dart';
import 'package:paritta_app/data/service/model/reader_config_model.dart';
import 'package:paritta_app/data/service/reader_config_service.dart';
import 'package:paritta_app/domain/model/reader_config.dart';
import 'package:paritta_app/domain/repository/reader_config_repository.dart';

class LocalReaderConfigRepository extends ReaderConfigRepository {
  LocalReaderConfigRepository(
      {required ReaderConfigService readerConfigService})
      : _readerConfigService = readerConfigService;

  final ReaderConfigService _readerConfigService;

  final Logger _log = Logger('LocalReaderConfigRepository');

  @override
  Future<ReaderConfig> getReaderConfig() async {
    try {
      final readerConfig = await _readerConfigService.get();

      return ReaderConfig(fontSize: readerConfig.fontSize);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }

  @override
  Future<void> saveReaderConfig(ReaderConfig readerConfig) async {
    try {
      final _readerConfig = ReaderConfigModel(fontSize: readerConfig.fontSize);
      
      await _readerConfigService.save(_readerConfig);
    } on Exception catch (error) {
      _log.severe(error);
      rethrow;
    }
  }
}
