// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meaning_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MeaningDto {

 int get order; String? get pos;@JsonKey(name: 'meaning_vi') String get meaningVi;@JsonKey(name: 'definition_en') String? get definitionEn;@JsonKey(name: 'example_en') String? get exampleEn;@JsonKey(name: 'example_vi') String? get exampleVi;
/// Create a copy of MeaningDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MeaningDtoCopyWith<MeaningDto> get copyWith => _$MeaningDtoCopyWithImpl<MeaningDto>(this as MeaningDto, _$identity);

  /// Serializes this MeaningDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MeaningDto&&(identical(other.order, order) || other.order == order)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.definitionEn, definitionEn) || other.definitionEn == definitionEn)&&(identical(other.exampleEn, exampleEn) || other.exampleEn == exampleEn)&&(identical(other.exampleVi, exampleVi) || other.exampleVi == exampleVi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,pos,meaningVi,definitionEn,exampleEn,exampleVi);

@override
String toString() {
  return 'MeaningDto(order: $order, pos: $pos, meaningVi: $meaningVi, definitionEn: $definitionEn, exampleEn: $exampleEn, exampleVi: $exampleVi)';
}


}

/// @nodoc
abstract mixin class $MeaningDtoCopyWith<$Res>  {
  factory $MeaningDtoCopyWith(MeaningDto value, $Res Function(MeaningDto) _then) = _$MeaningDtoCopyWithImpl;
@useResult
$Res call({
 int order, String? pos,@JsonKey(name: 'meaning_vi') String meaningVi,@JsonKey(name: 'definition_en') String? definitionEn,@JsonKey(name: 'example_en') String? exampleEn,@JsonKey(name: 'example_vi') String? exampleVi
});




}
/// @nodoc
class _$MeaningDtoCopyWithImpl<$Res>
    implements $MeaningDtoCopyWith<$Res> {
  _$MeaningDtoCopyWithImpl(this._self, this._then);

  final MeaningDto _self;
  final $Res Function(MeaningDto) _then;

/// Create a copy of MeaningDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? order = null,Object? pos = freezed,Object? meaningVi = null,Object? definitionEn = freezed,Object? exampleEn = freezed,Object? exampleVi = freezed,}) {
  return _then(_self.copyWith(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,pos: freezed == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as String?,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,definitionEn: freezed == definitionEn ? _self.definitionEn : definitionEn // ignore: cast_nullable_to_non_nullable
as String?,exampleEn: freezed == exampleEn ? _self.exampleEn : exampleEn // ignore: cast_nullable_to_non_nullable
as String?,exampleVi: freezed == exampleVi ? _self.exampleVi : exampleVi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MeaningDto].
extension MeaningDtoPatterns on MeaningDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MeaningDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MeaningDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MeaningDto value)  $default,){
final _that = this;
switch (_that) {
case _MeaningDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MeaningDto value)?  $default,){
final _that = this;
switch (_that) {
case _MeaningDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int order,  String? pos, @JsonKey(name: 'meaning_vi')  String meaningVi, @JsonKey(name: 'definition_en')  String? definitionEn, @JsonKey(name: 'example_en')  String? exampleEn, @JsonKey(name: 'example_vi')  String? exampleVi)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MeaningDto() when $default != null:
return $default(_that.order,_that.pos,_that.meaningVi,_that.definitionEn,_that.exampleEn,_that.exampleVi);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int order,  String? pos, @JsonKey(name: 'meaning_vi')  String meaningVi, @JsonKey(name: 'definition_en')  String? definitionEn, @JsonKey(name: 'example_en')  String? exampleEn, @JsonKey(name: 'example_vi')  String? exampleVi)  $default,) {final _that = this;
switch (_that) {
case _MeaningDto():
return $default(_that.order,_that.pos,_that.meaningVi,_that.definitionEn,_that.exampleEn,_that.exampleVi);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int order,  String? pos, @JsonKey(name: 'meaning_vi')  String meaningVi, @JsonKey(name: 'definition_en')  String? definitionEn, @JsonKey(name: 'example_en')  String? exampleEn, @JsonKey(name: 'example_vi')  String? exampleVi)?  $default,) {final _that = this;
switch (_that) {
case _MeaningDto() when $default != null:
return $default(_that.order,_that.pos,_that.meaningVi,_that.definitionEn,_that.exampleEn,_that.exampleVi);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MeaningDto extends MeaningDto {
  const _MeaningDto({this.order = 0, this.pos, @JsonKey(name: 'meaning_vi') required this.meaningVi, @JsonKey(name: 'definition_en') this.definitionEn, @JsonKey(name: 'example_en') this.exampleEn, @JsonKey(name: 'example_vi') this.exampleVi}): super._();
  factory _MeaningDto.fromJson(Map<String, dynamic> json) => _$MeaningDtoFromJson(json);

@override@JsonKey() final  int order;
@override final  String? pos;
@override@JsonKey(name: 'meaning_vi') final  String meaningVi;
@override@JsonKey(name: 'definition_en') final  String? definitionEn;
@override@JsonKey(name: 'example_en') final  String? exampleEn;
@override@JsonKey(name: 'example_vi') final  String? exampleVi;

/// Create a copy of MeaningDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MeaningDtoCopyWith<_MeaningDto> get copyWith => __$MeaningDtoCopyWithImpl<_MeaningDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MeaningDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MeaningDto&&(identical(other.order, order) || other.order == order)&&(identical(other.pos, pos) || other.pos == pos)&&(identical(other.meaningVi, meaningVi) || other.meaningVi == meaningVi)&&(identical(other.definitionEn, definitionEn) || other.definitionEn == definitionEn)&&(identical(other.exampleEn, exampleEn) || other.exampleEn == exampleEn)&&(identical(other.exampleVi, exampleVi) || other.exampleVi == exampleVi));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,order,pos,meaningVi,definitionEn,exampleEn,exampleVi);

@override
String toString() {
  return 'MeaningDto(order: $order, pos: $pos, meaningVi: $meaningVi, definitionEn: $definitionEn, exampleEn: $exampleEn, exampleVi: $exampleVi)';
}


}

/// @nodoc
abstract mixin class _$MeaningDtoCopyWith<$Res> implements $MeaningDtoCopyWith<$Res> {
  factory _$MeaningDtoCopyWith(_MeaningDto value, $Res Function(_MeaningDto) _then) = __$MeaningDtoCopyWithImpl;
@override @useResult
$Res call({
 int order, String? pos,@JsonKey(name: 'meaning_vi') String meaningVi,@JsonKey(name: 'definition_en') String? definitionEn,@JsonKey(name: 'example_en') String? exampleEn,@JsonKey(name: 'example_vi') String? exampleVi
});




}
/// @nodoc
class __$MeaningDtoCopyWithImpl<$Res>
    implements _$MeaningDtoCopyWith<$Res> {
  __$MeaningDtoCopyWithImpl(this._self, this._then);

  final _MeaningDto _self;
  final $Res Function(_MeaningDto) _then;

/// Create a copy of MeaningDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? order = null,Object? pos = freezed,Object? meaningVi = null,Object? definitionEn = freezed,Object? exampleEn = freezed,Object? exampleVi = freezed,}) {
  return _then(_MeaningDto(
order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,pos: freezed == pos ? _self.pos : pos // ignore: cast_nullable_to_non_nullable
as String?,meaningVi: null == meaningVi ? _self.meaningVi : meaningVi // ignore: cast_nullable_to_non_nullable
as String,definitionEn: freezed == definitionEn ? _self.definitionEn : definitionEn // ignore: cast_nullable_to_non_nullable
as String?,exampleEn: freezed == exampleEn ? _self.exampleEn : exampleEn // ignore: cast_nullable_to_non_nullable
as String?,exampleVi: freezed == exampleVi ? _self.exampleVi : exampleVi // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
