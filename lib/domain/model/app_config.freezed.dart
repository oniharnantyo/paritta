// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppConfig {
  ThemeMode get theme;
  Language get language;
  bool get notificationUposathaReminder;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $AppConfigCopyWith<AppConfig> get copyWith =>
      _$AppConfigCopyWithImpl<AppConfig>(this as AppConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppConfig &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.notificationUposathaReminder,
                    notificationUposathaReminder) ||
                other.notificationUposathaReminder ==
                    notificationUposathaReminder));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, theme, language, notificationUposathaReminder);

  @override
  String toString() {
    return 'AppConfig(theme: $theme, language: $language, notificationUposathaReminder: $notificationUposathaReminder)';
  }
}

/// @nodoc
abstract mixin class $AppConfigCopyWith<$Res> {
  factory $AppConfigCopyWith(AppConfig value, $Res Function(AppConfig) _then) =
      _$AppConfigCopyWithImpl;
  @useResult
  $Res call(
      {ThemeMode theme, Language language, bool notificationUposathaReminder});
}

/// @nodoc
class _$AppConfigCopyWithImpl<$Res> implements $AppConfigCopyWith<$Res> {
  _$AppConfigCopyWithImpl(this._self, this._then);

  final AppConfig _self;
  final $Res Function(AppConfig) _then;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? theme = null,
    Object? language = null,
    Object? notificationUposathaReminder = null,
  }) {
    return _then(_self.copyWith(
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      notificationUposathaReminder: null == notificationUposathaReminder
          ? _self.notificationUposathaReminder
          : notificationUposathaReminder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _AppConfig implements AppConfig {
  const _AppConfig(
      {required this.theme,
      required this.language,
      required this.notificationUposathaReminder});

  @override
  final ThemeMode theme;
  @override
  final Language language;
  @override
  final bool notificationUposathaReminder;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$AppConfigCopyWith<_AppConfig> get copyWith =>
      __$AppConfigCopyWithImpl<_AppConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _AppConfig &&
            (identical(other.theme, theme) || other.theme == theme) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.notificationUposathaReminder,
                    notificationUposathaReminder) ||
                other.notificationUposathaReminder ==
                    notificationUposathaReminder));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, theme, language, notificationUposathaReminder);

  @override
  String toString() {
    return 'AppConfig(theme: $theme, language: $language, notificationUposathaReminder: $notificationUposathaReminder)';
  }
}

/// @nodoc
abstract mixin class _$AppConfigCopyWith<$Res>
    implements $AppConfigCopyWith<$Res> {
  factory _$AppConfigCopyWith(
          _AppConfig value, $Res Function(_AppConfig) _then) =
      __$AppConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {ThemeMode theme, Language language, bool notificationUposathaReminder});
}

/// @nodoc
class __$AppConfigCopyWithImpl<$Res> implements _$AppConfigCopyWith<$Res> {
  __$AppConfigCopyWithImpl(this._self, this._then);

  final _AppConfig _self;
  final $Res Function(_AppConfig) _then;

  /// Create a copy of AppConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? theme = null,
    Object? language = null,
    Object? notificationUposathaReminder = null,
  }) {
    return _then(_AppConfig(
      theme: null == theme
          ? _self.theme
          : theme // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      language: null == language
          ? _self.language
          : language // ignore: cast_nullable_to_non_nullable
              as Language,
      notificationUposathaReminder: null == notificationUposathaReminder
          ? _self.notificationUposathaReminder
          : notificationUposathaReminder // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
