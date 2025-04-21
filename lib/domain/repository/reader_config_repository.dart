import 'package:paritta_app/domain/model/reader_config.dart';

abstract class ReaderConfigRepository {
  Future<ReaderConfig> getReaderConfig();

  Future<void> saveReaderConfig(ReaderConfig readerConfig);
}
