import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_config.freezed.dart';

enum Language { en, id }

@freezed
abstract class AppConfig with _$AppConfig {
  const factory AppConfig({
    required ThemeMode theme,
    required Language language,
  }) = _AppConfig;
}
