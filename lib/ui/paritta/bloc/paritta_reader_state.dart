part of 'paritta_reader_bloc.dart';

enum ParittaReaderStatus { initial, loading, success, error }

final class ParittaReaderState extends Equatable {
  const ParittaReaderState({
    this.status = ParittaReaderStatus.initial,
    this.error,
    this.readerConfig,
  });

  final ParittaReaderStatus status;
  final String? error;
  final ReaderConfig? readerConfig;

  ParittaReaderState copyWith({
    ParittaReaderStatus? status,
    String? error,
    ReaderConfig? readerConfig,
  }) {
    return ParittaReaderState(
      status: status ?? this.status,
      error: error ?? this.error,
      readerConfig: readerConfig ?? this.readerConfig,
    );
  }

  @override
  List<Object?> get props => [status, error, readerConfig];
}
