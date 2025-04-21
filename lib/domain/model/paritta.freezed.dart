// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paritta.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Paritta {
  String get text;

  /// Create a copy of Paritta
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $ParittaCopyWith<Paritta> get copyWith =>
      _$ParittaCopyWithImpl<Paritta>(this as Paritta, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Paritta &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @override
  String toString() {
    return 'Paritta(text: $text)';
  }
}

/// @nodoc
abstract mixin class $ParittaCopyWith<$Res> {
  factory $ParittaCopyWith(Paritta value, $Res Function(Paritta) _then) =
      _$ParittaCopyWithImpl;
  @useResult
  $Res call({String text});
}

/// @nodoc
class _$ParittaCopyWithImpl<$Res> implements $ParittaCopyWith<$Res> {
  _$ParittaCopyWithImpl(this._self, this._then);

  final Paritta _self;
  final $Res Function(Paritta) _then;

  /// Create a copy of Paritta
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? text = null,
  }) {
    return _then(_self.copyWith(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Paritta implements Paritta {
  const _Paritta({required this.text});

  @override
  final String text;

  /// Create a copy of Paritta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ParittaCopyWith<_Paritta> get copyWith =>
      __$ParittaCopyWithImpl<_Paritta>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Paritta &&
            (identical(other.text, text) || other.text == text));
  }

  @override
  int get hashCode => Object.hash(runtimeType, text);

  @override
  String toString() {
    return 'Paritta(text: $text)';
  }
}

/// @nodoc
abstract mixin class _$ParittaCopyWith<$Res> implements $ParittaCopyWith<$Res> {
  factory _$ParittaCopyWith(_Paritta value, $Res Function(_Paritta) _then) =
      __$ParittaCopyWithImpl;
  @override
  @useResult
  $Res call({String text});
}

/// @nodoc
class __$ParittaCopyWithImpl<$Res> implements _$ParittaCopyWith<$Res> {
  __$ParittaCopyWithImpl(this._self, this._then);

  final _Paritta _self;
  final $Res Function(_Paritta) _then;

  /// Create a copy of Paritta
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? text = null,
  }) {
    return _then(_Paritta(
      text: null == text
          ? _self.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
