// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_submit_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudySubmitDto {

 String get cardId; String get evaluatedRating; int get previousLevel; int get newLevel; int get previousInterval; int get newInterval; double? get easeFactor; DateTime? get dueDate; bool get isLeech;
/// Create a copy of StudySubmitDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudySubmitDtoCopyWith<StudySubmitDto> get copyWith => _$StudySubmitDtoCopyWithImpl<StudySubmitDto>(this as StudySubmitDto, _$identity);

  /// Serializes this StudySubmitDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudySubmitDto&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.evaluatedRating, evaluatedRating) || other.evaluatedRating == evaluatedRating)&&(identical(other.previousLevel, previousLevel) || other.previousLevel == previousLevel)&&(identical(other.newLevel, newLevel) || other.newLevel == newLevel)&&(identical(other.previousInterval, previousInterval) || other.previousInterval == previousInterval)&&(identical(other.newInterval, newInterval) || other.newInterval == newInterval)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isLeech, isLeech) || other.isLeech == isLeech));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardId,evaluatedRating,previousLevel,newLevel,previousInterval,newInterval,easeFactor,dueDate,isLeech);

@override
String toString() {
  return 'StudySubmitDto(cardId: $cardId, evaluatedRating: $evaluatedRating, previousLevel: $previousLevel, newLevel: $newLevel, previousInterval: $previousInterval, newInterval: $newInterval, easeFactor: $easeFactor, dueDate: $dueDate, isLeech: $isLeech)';
}


}

/// @nodoc
abstract mixin class $StudySubmitDtoCopyWith<$Res>  {
  factory $StudySubmitDtoCopyWith(StudySubmitDto value, $Res Function(StudySubmitDto) _then) = _$StudySubmitDtoCopyWithImpl;
@useResult
$Res call({
 String cardId, String evaluatedRating, int previousLevel, int newLevel, int previousInterval, int newInterval, double? easeFactor, DateTime? dueDate, bool isLeech
});




}
/// @nodoc
class _$StudySubmitDtoCopyWithImpl<$Res>
    implements $StudySubmitDtoCopyWith<$Res> {
  _$StudySubmitDtoCopyWithImpl(this._self, this._then);

  final StudySubmitDto _self;
  final $Res Function(StudySubmitDto) _then;

/// Create a copy of StudySubmitDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? evaluatedRating = null,Object? previousLevel = null,Object? newLevel = null,Object? previousInterval = null,Object? newInterval = null,Object? easeFactor = freezed,Object? dueDate = freezed,Object? isLeech = null,}) {
  return _then(_self.copyWith(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,evaluatedRating: null == evaluatedRating ? _self.evaluatedRating : evaluatedRating // ignore: cast_nullable_to_non_nullable
as String,previousLevel: null == previousLevel ? _self.previousLevel : previousLevel // ignore: cast_nullable_to_non_nullable
as int,newLevel: null == newLevel ? _self.newLevel : newLevel // ignore: cast_nullable_to_non_nullable
as int,previousInterval: null == previousInterval ? _self.previousInterval : previousInterval // ignore: cast_nullable_to_non_nullable
as int,newInterval: null == newInterval ? _self.newInterval : newInterval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: freezed == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isLeech: null == isLeech ? _self.isLeech : isLeech // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StudySubmitDto].
extension StudySubmitDtoPatterns on StudySubmitDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudySubmitDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudySubmitDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudySubmitDto value)  $default,){
final _that = this;
switch (_that) {
case _StudySubmitDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudySubmitDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudySubmitDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  String evaluatedRating,  int previousLevel,  int newLevel,  int previousInterval,  int newInterval,  double? easeFactor,  DateTime? dueDate,  bool isLeech)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudySubmitDto() when $default != null:
return $default(_that.cardId,_that.evaluatedRating,_that.previousLevel,_that.newLevel,_that.previousInterval,_that.newInterval,_that.easeFactor,_that.dueDate,_that.isLeech);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  String evaluatedRating,  int previousLevel,  int newLevel,  int previousInterval,  int newInterval,  double? easeFactor,  DateTime? dueDate,  bool isLeech)  $default,) {final _that = this;
switch (_that) {
case _StudySubmitDto():
return $default(_that.cardId,_that.evaluatedRating,_that.previousLevel,_that.newLevel,_that.previousInterval,_that.newInterval,_that.easeFactor,_that.dueDate,_that.isLeech);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  String evaluatedRating,  int previousLevel,  int newLevel,  int previousInterval,  int newInterval,  double? easeFactor,  DateTime? dueDate,  bool isLeech)?  $default,) {final _that = this;
switch (_that) {
case _StudySubmitDto() when $default != null:
return $default(_that.cardId,_that.evaluatedRating,_that.previousLevel,_that.newLevel,_that.previousInterval,_that.newInterval,_that.easeFactor,_that.dueDate,_that.isLeech);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudySubmitDto extends StudySubmitDto {
  const _StudySubmitDto({required this.cardId, required this.evaluatedRating, this.previousLevel = 0, this.newLevel = 0, this.previousInterval = 0, this.newInterval = 0, this.easeFactor, this.dueDate, this.isLeech = false}): super._();
  factory _StudySubmitDto.fromJson(Map<String, dynamic> json) => _$StudySubmitDtoFromJson(json);

@override final  String cardId;
@override final  String evaluatedRating;
@override@JsonKey() final  int previousLevel;
@override@JsonKey() final  int newLevel;
@override@JsonKey() final  int previousInterval;
@override@JsonKey() final  int newInterval;
@override final  double? easeFactor;
@override final  DateTime? dueDate;
@override@JsonKey() final  bool isLeech;

/// Create a copy of StudySubmitDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudySubmitDtoCopyWith<_StudySubmitDto> get copyWith => __$StudySubmitDtoCopyWithImpl<_StudySubmitDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudySubmitDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudySubmitDto&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.evaluatedRating, evaluatedRating) || other.evaluatedRating == evaluatedRating)&&(identical(other.previousLevel, previousLevel) || other.previousLevel == previousLevel)&&(identical(other.newLevel, newLevel) || other.newLevel == newLevel)&&(identical(other.previousInterval, previousInterval) || other.previousInterval == previousInterval)&&(identical(other.newInterval, newInterval) || other.newInterval == newInterval)&&(identical(other.easeFactor, easeFactor) || other.easeFactor == easeFactor)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.isLeech, isLeech) || other.isLeech == isLeech));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardId,evaluatedRating,previousLevel,newLevel,previousInterval,newInterval,easeFactor,dueDate,isLeech);

@override
String toString() {
  return 'StudySubmitDto(cardId: $cardId, evaluatedRating: $evaluatedRating, previousLevel: $previousLevel, newLevel: $newLevel, previousInterval: $previousInterval, newInterval: $newInterval, easeFactor: $easeFactor, dueDate: $dueDate, isLeech: $isLeech)';
}


}

/// @nodoc
abstract mixin class _$StudySubmitDtoCopyWith<$Res> implements $StudySubmitDtoCopyWith<$Res> {
  factory _$StudySubmitDtoCopyWith(_StudySubmitDto value, $Res Function(_StudySubmitDto) _then) = __$StudySubmitDtoCopyWithImpl;
@override @useResult
$Res call({
 String cardId, String evaluatedRating, int previousLevel, int newLevel, int previousInterval, int newInterval, double? easeFactor, DateTime? dueDate, bool isLeech
});




}
/// @nodoc
class __$StudySubmitDtoCopyWithImpl<$Res>
    implements _$StudySubmitDtoCopyWith<$Res> {
  __$StudySubmitDtoCopyWithImpl(this._self, this._then);

  final _StudySubmitDto _self;
  final $Res Function(_StudySubmitDto) _then;

/// Create a copy of StudySubmitDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? evaluatedRating = null,Object? previousLevel = null,Object? newLevel = null,Object? previousInterval = null,Object? newInterval = null,Object? easeFactor = freezed,Object? dueDate = freezed,Object? isLeech = null,}) {
  return _then(_StudySubmitDto(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,evaluatedRating: null == evaluatedRating ? _self.evaluatedRating : evaluatedRating // ignore: cast_nullable_to_non_nullable
as String,previousLevel: null == previousLevel ? _self.previousLevel : previousLevel // ignore: cast_nullable_to_non_nullable
as int,newLevel: null == newLevel ? _self.newLevel : newLevel // ignore: cast_nullable_to_non_nullable
as int,previousInterval: null == previousInterval ? _self.previousInterval : previousInterval // ignore: cast_nullable_to_non_nullable
as int,newInterval: null == newInterval ? _self.newInterval : newInterval // ignore: cast_nullable_to_non_nullable
as int,easeFactor: freezed == easeFactor ? _self.easeFactor : easeFactor // ignore: cast_nullable_to_non_nullable
as double?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isLeech: null == isLeech ? _self.isLeech : isLeech // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
