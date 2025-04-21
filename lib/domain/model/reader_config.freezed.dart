// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReaderConfig {
  double get fontSize;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ReaderConfigCopyWith<ReaderConfig> get copyWith =>
      _$ReaderConfigCopyWithImpl<ReaderConfig>(
          this as ReaderConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ReaderConfig &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fontSize);

  @override
  String toString() {
    return 'ReaderConfig(fontSize: $fontSize)';
  }
}

/// @nodoc
abstract mixin class $ReaderConfigCopyWith<$Res> {
  factory $ReaderConfigCopyWith(
          ReaderConfig value, $Res Function(ReaderConfig) _then) =
      _$ReaderConfigCopyWithImpl;
  @useResult
  $Res call({double fontSize});
}

/// @nodoc
class _$ReaderConfigCopyWithImpl<$Res> implements $ReaderConfigCopyWith<$Res> {
  _$ReaderConfigCopyWithImpl(this._self, this._then);

  final ReaderConfig _self;
  final $Res Function(ReaderConfig) _then;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontSize = null,
  }) {
    return _then(_self.copyWith(
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _ReaderConfig implements ReaderConfig {
  const _ReaderConfig({required this.fontSize});

  @override
  final double fontSize;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReaderConfigCopyWith<_ReaderConfig> get copyWith =>
      __$ReaderConfigCopyWithImpl<_ReaderConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReaderConfig &&
            (identical(other.fontSize, fontSize) ||
                other.fontSize == fontSize));
  }

  @override
  int get hashCode => Object.hash(runtimeType, fontSize);

  @override
  String toString() {
    return 'ReaderConfig(fontSize: $fontSize)';
  }
}

/// @nodoc
abstract mixin class _$ReaderConfigCopyWith<$Res>
    implements $ReaderConfigCopyWith<$Res> {
  factory _$ReaderConfigCopyWith(
          _ReaderConfig value, $Res Function(_ReaderConfig) _then) =
      __$ReaderConfigCopyWithImpl;
  @override
  @useResult
  $Res call({double fontSize});
}

/// @nodoc
class __$ReaderConfigCopyWithImpl<$Res>
    implements _$ReaderConfigCopyWith<$Res> {
  __$ReaderConfigCopyWithImpl(this._self, this._then);

  final _ReaderConfig _self;
  final $Res Function(_ReaderConfig) _then;

  /// Create a copy of ReaderConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? fontSize = null,
  }) {
    return _then(_ReaderConfig(
      fontSize: null == fontSize
          ? _self.fontSize
          : fontSize // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

// dart format on
