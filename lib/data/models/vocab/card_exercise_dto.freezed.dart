// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_exercise_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardExerciseDto {

 String? get id; String? get cardId; String get exerciseType; String? get meaningHint; String get targetSentence; String? get vietnameseTranslation; List<String> get tokens; List<String> get distractorTokens; int get targetIndex; String? get audioUrl;
/// Create a copy of CardExerciseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardExerciseDtoCopyWith<CardExerciseDto> get copyWith => _$CardExerciseDtoCopyWithImpl<CardExerciseDto>(this as CardExerciseDto, _$identity);

  /// Serializes this CardExerciseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&(identical(other.meaningHint, meaningHint) || other.meaningHint == meaningHint)&&(identical(other.targetSentence, targetSentence) || other.targetSentence == targetSentence)&&(identical(other.vietnameseTranslation, vietnameseTranslation) || other.vietnameseTranslation == vietnameseTranslation)&&const DeepCollectionEquality().equals(other.tokens, tokens)&&const DeepCollectionEquality().equals(other.distractorTokens, distractorTokens)&&(identical(other.targetIndex, targetIndex) || other.targetIndex == targetIndex)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardId,exerciseType,meaningHint,targetSentence,vietnameseTranslation,const DeepCollectionEquality().hash(tokens),const DeepCollectionEquality().hash(distractorTokens),targetIndex,audioUrl);

@override
String toString() {
  return 'CardExerciseDto(id: $id, cardId: $cardId, exerciseType: $exerciseType, meaningHint: $meaningHint, targetSentence: $targetSentence, vietnameseTranslation: $vietnameseTranslation, tokens: $tokens, distractorTokens: $distractorTokens, targetIndex: $targetIndex, audioUrl: $audioUrl)';
}


}

/// @nodoc
abstract mixin class $CardExerciseDtoCopyWith<$Res>  {
  factory $CardExerciseDtoCopyWith(CardExerciseDto value, $Res Function(CardExerciseDto) _then) = _$CardExerciseDtoCopyWithImpl;
@useResult
$Res call({
 String? id, String? cardId, String exerciseType, String? meaningHint, String targetSentence, String? vietnameseTranslation, List<String> tokens, List<String> distractorTokens, int targetIndex, String? audioUrl
});




}
/// @nodoc
class _$CardExerciseDtoCopyWithImpl<$Res>
    implements $CardExerciseDtoCopyWith<$Res> {
  _$CardExerciseDtoCopyWithImpl(this._self, this._then);

  final CardExerciseDto _self;
  final $Res Function(CardExerciseDto) _then;

/// Create a copy of CardExerciseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? cardId = freezed,Object? exerciseType = null,Object? meaningHint = freezed,Object? targetSentence = null,Object? vietnameseTranslation = freezed,Object? tokens = null,Object? distractorTokens = null,Object? targetIndex = null,Object? audioUrl = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String?,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as String,meaningHint: freezed == meaningHint ? _self.meaningHint : meaningHint // ignore: cast_nullable_to_non_nullable
as String?,targetSentence: null == targetSentence ? _self.targetSentence : targetSentence // ignore: cast_nullable_to_non_nullable
as String,vietnameseTranslation: freezed == vietnameseTranslation ? _self.vietnameseTranslation : vietnameseTranslation // ignore: cast_nullable_to_non_nullable
as String?,tokens: null == tokens ? _self.tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>,distractorTokens: null == distractorTokens ? _self.distractorTokens : distractorTokens // ignore: cast_nullable_to_non_nullable
as List<String>,targetIndex: null == targetIndex ? _self.targetIndex : targetIndex // ignore: cast_nullable_to_non_nullable
as int,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CardExerciseDto].
extension CardExerciseDtoPatterns on CardExerciseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardExerciseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardExerciseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardExerciseDto value)  $default,){
final _that = this;
switch (_that) {
case _CardExerciseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardExerciseDto value)?  $default,){
final _that = this;
switch (_that) {
case _CardExerciseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? cardId,  String exerciseType,  String? meaningHint,  String targetSentence,  String? vietnameseTranslation,  List<String> tokens,  List<String> distractorTokens,  int targetIndex,  String? audioUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardExerciseDto() when $default != null:
return $default(_that.id,_that.cardId,_that.exerciseType,_that.meaningHint,_that.targetSentence,_that.vietnameseTranslation,_that.tokens,_that.distractorTokens,_that.targetIndex,_that.audioUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? cardId,  String exerciseType,  String? meaningHint,  String targetSentence,  String? vietnameseTranslation,  List<String> tokens,  List<String> distractorTokens,  int targetIndex,  String? audioUrl)  $default,) {final _that = this;
switch (_that) {
case _CardExerciseDto():
return $default(_that.id,_that.cardId,_that.exerciseType,_that.meaningHint,_that.targetSentence,_that.vietnameseTranslation,_that.tokens,_that.distractorTokens,_that.targetIndex,_that.audioUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? cardId,  String exerciseType,  String? meaningHint,  String targetSentence,  String? vietnameseTranslation,  List<String> tokens,  List<String> distractorTokens,  int targetIndex,  String? audioUrl)?  $default,) {final _that = this;
switch (_that) {
case _CardExerciseDto() when $default != null:
return $default(_that.id,_that.cardId,_that.exerciseType,_that.meaningHint,_that.targetSentence,_that.vietnameseTranslation,_that.tokens,_that.distractorTokens,_that.targetIndex,_that.audioUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardExerciseDto extends CardExerciseDto {
  const _CardExerciseDto({this.id, this.cardId, this.exerciseType = 'fill_blank', this.meaningHint, required this.targetSentence, this.vietnameseTranslation, final  List<String> tokens = const [], final  List<String> distractorTokens = const [], this.targetIndex = 0, this.audioUrl}): _tokens = tokens,_distractorTokens = distractorTokens,super._();
  factory _CardExerciseDto.fromJson(Map<String, dynamic> json) => _$CardExerciseDtoFromJson(json);

@override final  String? id;
@override final  String? cardId;
@override@JsonKey() final  String exerciseType;
@override final  String? meaningHint;
@override final  String targetSentence;
@override final  String? vietnameseTranslation;
 final  List<String> _tokens;
@override@JsonKey() List<String> get tokens {
  if (_tokens is EqualUnmodifiableListView) return _tokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tokens);
}

 final  List<String> _distractorTokens;
@override@JsonKey() List<String> get distractorTokens {
  if (_distractorTokens is EqualUnmodifiableListView) return _distractorTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_distractorTokens);
}

@override@JsonKey() final  int targetIndex;
@override final  String? audioUrl;

/// Create a copy of CardExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardExerciseDtoCopyWith<_CardExerciseDto> get copyWith => __$CardExerciseDtoCopyWithImpl<_CardExerciseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardExerciseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardExerciseDto&&(identical(other.id, id) || other.id == id)&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.exerciseType, exerciseType) || other.exerciseType == exerciseType)&&(identical(other.meaningHint, meaningHint) || other.meaningHint == meaningHint)&&(identical(other.targetSentence, targetSentence) || other.targetSentence == targetSentence)&&(identical(other.vietnameseTranslation, vietnameseTranslation) || other.vietnameseTranslation == vietnameseTranslation)&&const DeepCollectionEquality().equals(other._tokens, _tokens)&&const DeepCollectionEquality().equals(other._distractorTokens, _distractorTokens)&&(identical(other.targetIndex, targetIndex) || other.targetIndex == targetIndex)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,cardId,exerciseType,meaningHint,targetSentence,vietnameseTranslation,const DeepCollectionEquality().hash(_tokens),const DeepCollectionEquality().hash(_distractorTokens),targetIndex,audioUrl);

@override
String toString() {
  return 'CardExerciseDto(id: $id, cardId: $cardId, exerciseType: $exerciseType, meaningHint: $meaningHint, targetSentence: $targetSentence, vietnameseTranslation: $vietnameseTranslation, tokens: $tokens, distractorTokens: $distractorTokens, targetIndex: $targetIndex, audioUrl: $audioUrl)';
}


}

/// @nodoc
abstract mixin class _$CardExerciseDtoCopyWith<$Res> implements $CardExerciseDtoCopyWith<$Res> {
  factory _$CardExerciseDtoCopyWith(_CardExerciseDto value, $Res Function(_CardExerciseDto) _then) = __$CardExerciseDtoCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? cardId, String exerciseType, String? meaningHint, String targetSentence, String? vietnameseTranslation, List<String> tokens, List<String> distractorTokens, int targetIndex, String? audioUrl
});




}
/// @nodoc
class __$CardExerciseDtoCopyWithImpl<$Res>
    implements _$CardExerciseDtoCopyWith<$Res> {
  __$CardExerciseDtoCopyWithImpl(this._self, this._then);

  final _CardExerciseDto _self;
  final $Res Function(_CardExerciseDto) _then;

/// Create a copy of CardExerciseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? cardId = freezed,Object? exerciseType = null,Object? meaningHint = freezed,Object? targetSentence = null,Object? vietnameseTranslation = freezed,Object? tokens = null,Object? distractorTokens = null,Object? targetIndex = null,Object? audioUrl = freezed,}) {
  return _then(_CardExerciseDto(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,cardId: freezed == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String?,exerciseType: null == exerciseType ? _self.exerciseType : exerciseType // ignore: cast_nullable_to_non_nullable
as String,meaningHint: freezed == meaningHint ? _self.meaningHint : meaningHint // ignore: cast_nullable_to_non_nullable
as String?,targetSentence: null == targetSentence ? _self.targetSentence : targetSentence // ignore: cast_nullable_to_non_nullable
as String,vietnameseTranslation: freezed == vietnameseTranslation ? _self.vietnameseTranslation : vietnameseTranslation // ignore: cast_nullable_to_non_nullable
as String?,tokens: null == tokens ? _self._tokens : tokens // ignore: cast_nullable_to_non_nullable
as List<String>,distractorTokens: null == distractorTokens ? _self._distractorTokens : distractorTokens // ignore: cast_nullable_to_non_nullable
as List<String>,targetIndex: null == targetIndex ? _self.targetIndex : targetIndex // ignore: cast_nullable_to_non_nullable
as int,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
