import 'package:freezed_annotation/freezed_annotation.dart';

part 'reader_config.freezed.dart';

@freezed
abstract class ReaderConfig with _$ReaderConfig {
  const factory ReaderConfig({
    required double fontSize,
  }) = _ReaderConfig;
}
