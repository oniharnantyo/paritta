part of 'paritta_reader_bloc.dart';

sealed class ParittaReaderEvent extends Equatable {
  const ParittaReaderEvent();

  @override
  List<Object?> get props => [];
}

final class ParittaReaderConfigRequested extends ParittaReaderEvent {
  const ParittaReaderConfigRequested();
}

final class ParittaReaderConfigSaved extends ParittaReaderEvent {
  const ParittaReaderConfigSaved(this.readerConfig);

  final ReaderConfig readerConfig;

  @override
  List<Object?> get props => [readerConfig];
}
