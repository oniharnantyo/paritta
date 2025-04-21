import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:paritta_app/domain/model/reader_config.dart';
import 'package:paritta_app/domain/repository/reader_config_repository.dart';

part 'paritta_reader_event.dart';
part 'paritta_reader_state.dart';

class ParittaReaderBloc extends Bloc<ParittaReaderEvent, ParittaReaderState> {
  ParittaReaderBloc({required ReaderConfigRepository readerConfigRepository})
      : _readerConfigRepository = readerConfigRepository,
        super(const ParittaReaderState()) {
    on<ParittaReaderConfigRequested>(_onParittaReaderConfigRequested);
    on<ParittaReaderConfigSaved>(_onParittaReaderConfigSaved);
  }

  final ReaderConfigRepository _readerConfigRepository;

  Future<void> _onParittaReaderConfigRequested(
    ParittaReaderConfigRequested event,
    Emitter<ParittaReaderState> emit,
  ) async {
    emit(state.copyWith(status: ParittaReaderStatus.loading));
    try {
      final readerConfig = await _readerConfigRepository.getReaderConfig();
      emit(state.copyWith(
        status: ParittaReaderStatus.success,
        readerConfig: readerConfig,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaReaderStatus.error,
          error: error.toString(),
        ),
      );
    }
  }

  Future<void> _onParittaReaderConfigSaved(
    ParittaReaderConfigSaved event,
    Emitter<ParittaReaderState> emit,
  ) async {
    emit(state.copyWith(status: ParittaReaderStatus.loading));
    try {
      await _readerConfigRepository.saveReaderConfig(event.readerConfig);
      emit(state.copyWith(
        status: ParittaReaderStatus.success,
        readerConfig: event.readerConfig,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          status: ParittaReaderStatus.error,
          error: error.toString(),
        ),
      );
    }
  }
}
