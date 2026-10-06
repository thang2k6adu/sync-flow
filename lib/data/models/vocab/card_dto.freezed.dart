// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'card_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CardDto {

 String get id; String get deckId; String get term; String? get phonetic; String? get audioUrl; String? get cefrLevel; int? get frequencyRank; String? get wordFamilyId; List<String> get tagIds; List<MeaningDto> get meanings; List<String> get collocations; List<CardExerciseDto> get exercises;
/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CardDtoCopyWith<CardDto> get copyWith => _$CardDtoCopyWithImpl<CardDto>(this as CardDto, _$identity);

  /// Serializes this CardDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.term, term) || other.term == term)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.cefrLevel, cefrLevel) || other.cefrLevel == cefrLevel)&&(identical(other.frequencyRank, frequencyRank) || other.frequencyRank == frequencyRank)&&(identical(other.wordFamilyId, wordFamilyId) || other.wordFamilyId == wordFamilyId)&&const DeepCollectionEquality().equals(other.tagIds, tagIds)&&const DeepCollectionEquality().equals(other.meanings, meanings)&&const DeepCollectionEquality().equals(other.collocations, collocations)&&const DeepCollectionEquality().equals(other.exercises, exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deckId,term,phonetic,audioUrl,cefrLevel,frequencyRank,wordFamilyId,const DeepCollectionEquality().hash(tagIds),const DeepCollectionEquality().hash(meanings),const DeepCollectionEquality().hash(collocations),const DeepCollectionEquality().hash(exercises));

@override
String toString() {
  return 'CardDto(id: $id, deckId: $deckId, term: $term, phonetic: $phonetic, audioUrl: $audioUrl, cefrLevel: $cefrLevel, frequencyRank: $frequencyRank, wordFamilyId: $wordFamilyId, tagIds: $tagIds, meanings: $meanings, collocations: $collocations, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class $CardDtoCopyWith<$Res>  {
  factory $CardDtoCopyWith(CardDto value, $Res Function(CardDto) _then) = _$CardDtoCopyWithImpl;
@useResult
$Res call({
 String id, String deckId, String term, String? phonetic, String? audioUrl, String? cefrLevel, int? frequencyRank, String? wordFamilyId, List<String> tagIds, List<MeaningDto> meanings, List<String> collocations, List<CardExerciseDto> exercises
});




}
/// @nodoc
class _$CardDtoCopyWithImpl<$Res>
    implements $CardDtoCopyWith<$Res> {
  _$CardDtoCopyWithImpl(this._self, this._then);

  final CardDto _self;
  final $Res Function(CardDto) _then;

/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? deckId = null,Object? term = null,Object? phonetic = freezed,Object? audioUrl = freezed,Object? cefrLevel = freezed,Object? frequencyRank = freezed,Object? wordFamilyId = freezed,Object? tagIds = null,Object? meanings = null,Object? collocations = null,Object? exercises = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,phonetic: freezed == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,cefrLevel: freezed == cefrLevel ? _self.cefrLevel : cefrLevel // ignore: cast_nullable_to_non_nullable
as String?,frequencyRank: freezed == frequencyRank ? _self.frequencyRank : frequencyRank // ignore: cast_nullable_to_non_nullable
as int?,wordFamilyId: freezed == wordFamilyId ? _self.wordFamilyId : wordFamilyId // ignore: cast_nullable_to_non_nullable
as String?,tagIds: null == tagIds ? _self.tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,meanings: null == meanings ? _self.meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<MeaningDto>,collocations: null == collocations ? _self.collocations : collocations // ignore: cast_nullable_to_non_nullable
as List<String>,exercises: null == exercises ? _self.exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<CardExerciseDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [CardDto].
extension CardDtoPatterns on CardDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CardDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CardDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CardDto value)  $default,){
final _that = this;
switch (_that) {
case _CardDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CardDto value)?  $default,){
final _that = this;
switch (_that) {
case _CardDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String deckId,  String term,  String? phonetic,  String? audioUrl,  String? cefrLevel,  int? frequencyRank,  String? wordFamilyId,  List<String> tagIds,  List<MeaningDto> meanings,  List<String> collocations,  List<CardExerciseDto> exercises)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that.id,_that.deckId,_that.term,_that.phonetic,_that.audioUrl,_that.cefrLevel,_that.frequencyRank,_that.wordFamilyId,_that.tagIds,_that.meanings,_that.collocations,_that.exercises);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String deckId,  String term,  String? phonetic,  String? audioUrl,  String? cefrLevel,  int? frequencyRank,  String? wordFamilyId,  List<String> tagIds,  List<MeaningDto> meanings,  List<String> collocations,  List<CardExerciseDto> exercises)  $default,) {final _that = this;
switch (_that) {
case _CardDto():
return $default(_that.id,_that.deckId,_that.term,_that.phonetic,_that.audioUrl,_that.cefrLevel,_that.frequencyRank,_that.wordFamilyId,_that.tagIds,_that.meanings,_that.collocations,_that.exercises);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String deckId,  String term,  String? phonetic,  String? audioUrl,  String? cefrLevel,  int? frequencyRank,  String? wordFamilyId,  List<String> tagIds,  List<MeaningDto> meanings,  List<String> collocations,  List<CardExerciseDto> exercises)?  $default,) {final _that = this;
switch (_that) {
case _CardDto() when $default != null:
return $default(_that.id,_that.deckId,_that.term,_that.phonetic,_that.audioUrl,_that.cefrLevel,_that.frequencyRank,_that.wordFamilyId,_that.tagIds,_that.meanings,_that.collocations,_that.exercises);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CardDto extends CardDto {
  const _CardDto({required this.id, required this.deckId, required this.term, this.phonetic, this.audioUrl, this.cefrLevel, this.frequencyRank, this.wordFamilyId, final  List<String> tagIds = const [], final  List<MeaningDto> meanings = const [], final  List<String> collocations = const [], final  List<CardExerciseDto> exercises = const []}): _tagIds = tagIds,_meanings = meanings,_collocations = collocations,_exercises = exercises,super._();
  factory _CardDto.fromJson(Map<String, dynamic> json) => _$CardDtoFromJson(json);

@override final  String id;
@override final  String deckId;
@override final  String term;
@override final  String? phonetic;
@override final  String? audioUrl;
@override final  String? cefrLevel;
@override final  int? frequencyRank;
@override final  String? wordFamilyId;
 final  List<String> _tagIds;
@override@JsonKey() List<String> get tagIds {
  if (_tagIds is EqualUnmodifiableListView) return _tagIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tagIds);
}

 final  List<MeaningDto> _meanings;
@override@JsonKey() List<MeaningDto> get meanings {
  if (_meanings is EqualUnmodifiableListView) return _meanings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meanings);
}

 final  List<String> _collocations;
@override@JsonKey() List<String> get collocations {
  if (_collocations is EqualUnmodifiableListView) return _collocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_collocations);
}

 final  List<CardExerciseDto> _exercises;
@override@JsonKey() List<CardExerciseDto> get exercises {
  if (_exercises is EqualUnmodifiableListView) return _exercises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_exercises);
}


/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CardDtoCopyWith<_CardDto> get copyWith => __$CardDtoCopyWithImpl<_CardDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CardDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CardDto&&(identical(other.id, id) || other.id == id)&&(identical(other.deckId, deckId) || other.deckId == deckId)&&(identical(other.term, term) || other.term == term)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.cefrLevel, cefrLevel) || other.cefrLevel == cefrLevel)&&(identical(other.frequencyRank, frequencyRank) || other.frequencyRank == frequencyRank)&&(identical(other.wordFamilyId, wordFamilyId) || other.wordFamilyId == wordFamilyId)&&const DeepCollectionEquality().equals(other._tagIds, _tagIds)&&const DeepCollectionEquality().equals(other._meanings, _meanings)&&const DeepCollectionEquality().equals(other._collocations, _collocations)&&const DeepCollectionEquality().equals(other._exercises, _exercises));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,deckId,term,phonetic,audioUrl,cefrLevel,frequencyRank,wordFamilyId,const DeepCollectionEquality().hash(_tagIds),const DeepCollectionEquality().hash(_meanings),const DeepCollectionEquality().hash(_collocations),const DeepCollectionEquality().hash(_exercises));

@override
String toString() {
  return 'CardDto(id: $id, deckId: $deckId, term: $term, phonetic: $phonetic, audioUrl: $audioUrl, cefrLevel: $cefrLevel, frequencyRank: $frequencyRank, wordFamilyId: $wordFamilyId, tagIds: $tagIds, meanings: $meanings, collocations: $collocations, exercises: $exercises)';
}


}

/// @nodoc
abstract mixin class _$CardDtoCopyWith<$Res> implements $CardDtoCopyWith<$Res> {
  factory _$CardDtoCopyWith(_CardDto value, $Res Function(_CardDto) _then) = __$CardDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String deckId, String term, String? phonetic, String? audioUrl, String? cefrLevel, int? frequencyRank, String? wordFamilyId, List<String> tagIds, List<MeaningDto> meanings, List<String> collocations, List<CardExerciseDto> exercises
});




}
/// @nodoc
class __$CardDtoCopyWithImpl<$Res>
    implements _$CardDtoCopyWith<$Res> {
  __$CardDtoCopyWithImpl(this._self, this._then);

  final _CardDto _self;
  final $Res Function(_CardDto) _then;

/// Create a copy of CardDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? deckId = null,Object? term = null,Object? phonetic = freezed,Object? audioUrl = freezed,Object? cefrLevel = freezed,Object? frequencyRank = freezed,Object? wordFamilyId = freezed,Object? tagIds = null,Object? meanings = null,Object? collocations = null,Object? exercises = null,}) {
  return _then(_CardDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,deckId: null == deckId ? _self.deckId : deckId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,phonetic: freezed == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,cefrLevel: freezed == cefrLevel ? _self.cefrLevel : cefrLevel // ignore: cast_nullable_to_non_nullable
as String?,frequencyRank: freezed == frequencyRank ? _self.frequencyRank : frequencyRank // ignore: cast_nullable_to_non_nullable
as int?,wordFamilyId: freezed == wordFamilyId ? _self.wordFamilyId : wordFamilyId // ignore: cast_nullable_to_non_nullable
as String?,tagIds: null == tagIds ? _self._tagIds : tagIds // ignore: cast_nullable_to_non_nullable
as List<String>,meanings: null == meanings ? _self._meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<MeaningDto>,collocations: null == collocations ? _self._collocations : collocations // ignore: cast_nullable_to_non_nullable
as List<String>,exercises: null == exercises ? _self._exercises : exercises // ignore: cast_nullable_to_non_nullable
as List<CardExerciseDto>,
  ));
}


}

// dart format on
