// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Quote {
  String get quote;
  String get source;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $QuoteCopyWith<Quote> get copyWith =>
      _$QuoteCopyWithImpl<Quote>(this as Quote, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is Quote &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quote, source);

  @override
  String toString() {
    return 'Quote(quote: $quote, source: $source)';
  }
}

/// @nodoc
abstract mixin class $QuoteCopyWith<$Res> {
  factory $QuoteCopyWith(Quote value, $Res Function(Quote) _then) =
      _$QuoteCopyWithImpl;
  @useResult
  $Res call({String quote, String source});
}

/// @nodoc
class _$QuoteCopyWithImpl<$Res> implements $QuoteCopyWith<$Res> {
  _$QuoteCopyWithImpl(this._self, this._then);

  final Quote _self;
  final $Res Function(Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quote = null,
    Object? source = null,
  }) {
    return _then(_self.copyWith(
      quote: null == quote
          ? _self.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Quote implements Quote {
  const _Quote({required this.quote, required this.source});

  @override
  final String quote;
  @override
  final String source;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QuoteCopyWith<_Quote> get copyWith =>
      __$QuoteCopyWithImpl<_Quote>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Quote &&
            (identical(other.quote, quote) || other.quote == quote) &&
            (identical(other.source, source) || other.source == source));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quote, source);

  @override
  String toString() {
    return 'Quote(quote: $quote, source: $source)';
  }
}

/// @nodoc
abstract mixin class _$QuoteCopyWith<$Res> implements $QuoteCopyWith<$Res> {
  factory _$QuoteCopyWith(_Quote value, $Res Function(_Quote) _then) =
      __$QuoteCopyWithImpl;
  @override
  @useResult
  $Res call({String quote, String source});
}

/// @nodoc
class __$QuoteCopyWithImpl<$Res> implements _$QuoteCopyWith<$Res> {
  __$QuoteCopyWithImpl(this._self, this._then);

  final _Quote _self;
  final $Res Function(_Quote) _then;

  /// Create a copy of Quote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? quote = null,
    Object? source = null,
  }) {
    return _then(_Quote(
      quote: null == quote
          ? _self.quote
          : quote // ignore: cast_nullable_to_non_nullable
              as String,
      source: null == source
          ? _self.source
          : source // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
