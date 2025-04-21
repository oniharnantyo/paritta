import 'package:freezed_annotation/freezed_annotation.dart';

part 'paritta.freezed.dart';

@freezed
abstract class Paritta with _$Paritta {
  const factory Paritta({required String text}) = _Paritta;
}
