// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_queue_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$StudyQueueItemDto {

 String get cardId; String get term; String? get phonetic; String? get audioUrl; int get masteryLevel; String get state; int get lapsesCount; bool get isLeech; List<MeaningDto> get meanings; CardExerciseDto? get currentExercise;
/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyQueueItemDtoCopyWith<StudyQueueItemDto> get copyWith => _$StudyQueueItemDtoCopyWithImpl<StudyQueueItemDto>(this as StudyQueueItemDto, _$identity);

  /// Serializes this StudyQueueItemDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyQueueItemDto&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.term, term) || other.term == term)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.masteryLevel, masteryLevel) || other.masteryLevel == masteryLevel)&&(identical(other.state, state) || other.state == state)&&(identical(other.lapsesCount, lapsesCount) || other.lapsesCount == lapsesCount)&&(identical(other.isLeech, isLeech) || other.isLeech == isLeech)&&const DeepCollectionEquality().equals(other.meanings, meanings)&&(identical(other.currentExercise, currentExercise) || other.currentExercise == currentExercise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardId,term,phonetic,audioUrl,masteryLevel,state,lapsesCount,isLeech,const DeepCollectionEquality().hash(meanings),currentExercise);

@override
String toString() {
  return 'StudyQueueItemDto(cardId: $cardId, term: $term, phonetic: $phonetic, audioUrl: $audioUrl, masteryLevel: $masteryLevel, state: $state, lapsesCount: $lapsesCount, isLeech: $isLeech, meanings: $meanings, currentExercise: $currentExercise)';
}


}

/// @nodoc
abstract mixin class $StudyQueueItemDtoCopyWith<$Res>  {
  factory $StudyQueueItemDtoCopyWith(StudyQueueItemDto value, $Res Function(StudyQueueItemDto) _then) = _$StudyQueueItemDtoCopyWithImpl;
@useResult
$Res call({
 String cardId, String term, String? phonetic, String? audioUrl, int masteryLevel, String state, int lapsesCount, bool isLeech, List<MeaningDto> meanings, CardExerciseDto? currentExercise
});


$CardExerciseDtoCopyWith<$Res>? get currentExercise;

}
/// @nodoc
class _$StudyQueueItemDtoCopyWithImpl<$Res>
    implements $StudyQueueItemDtoCopyWith<$Res> {
  _$StudyQueueItemDtoCopyWithImpl(this._self, this._then);

  final StudyQueueItemDto _self;
  final $Res Function(StudyQueueItemDto) _then;

/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardId = null,Object? term = null,Object? phonetic = freezed,Object? audioUrl = freezed,Object? masteryLevel = null,Object? state = null,Object? lapsesCount = null,Object? isLeech = null,Object? meanings = null,Object? currentExercise = freezed,}) {
  return _then(_self.copyWith(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,phonetic: freezed == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,masteryLevel: null == masteryLevel ? _self.masteryLevel : masteryLevel // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,lapsesCount: null == lapsesCount ? _self.lapsesCount : lapsesCount // ignore: cast_nullable_to_non_nullable
as int,isLeech: null == isLeech ? _self.isLeech : isLeech // ignore: cast_nullable_to_non_nullable
as bool,meanings: null == meanings ? _self.meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<MeaningDto>,currentExercise: freezed == currentExercise ? _self.currentExercise : currentExercise // ignore: cast_nullable_to_non_nullable
as CardExerciseDto?,
  ));
}
/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardExerciseDtoCopyWith<$Res>? get currentExercise {
    if (_self.currentExercise == null) {
    return null;
  }

  return $CardExerciseDtoCopyWith<$Res>(_self.currentExercise!, (value) {
    return _then(_self.copyWith(currentExercise: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyQueueItemDto].
extension StudyQueueItemDtoPatterns on StudyQueueItemDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyQueueItemDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyQueueItemDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyQueueItemDto value)  $default,){
final _that = this;
switch (_that) {
case _StudyQueueItemDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyQueueItemDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudyQueueItemDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardId,  String term,  String? phonetic,  String? audioUrl,  int masteryLevel,  String state,  int lapsesCount,  bool isLeech,  List<MeaningDto> meanings,  CardExerciseDto? currentExercise)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyQueueItemDto() when $default != null:
return $default(_that.cardId,_that.term,_that.phonetic,_that.audioUrl,_that.masteryLevel,_that.state,_that.lapsesCount,_that.isLeech,_that.meanings,_that.currentExercise);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardId,  String term,  String? phonetic,  String? audioUrl,  int masteryLevel,  String state,  int lapsesCount,  bool isLeech,  List<MeaningDto> meanings,  CardExerciseDto? currentExercise)  $default,) {final _that = this;
switch (_that) {
case _StudyQueueItemDto():
return $default(_that.cardId,_that.term,_that.phonetic,_that.audioUrl,_that.masteryLevel,_that.state,_that.lapsesCount,_that.isLeech,_that.meanings,_that.currentExercise);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardId,  String term,  String? phonetic,  String? audioUrl,  int masteryLevel,  String state,  int lapsesCount,  bool isLeech,  List<MeaningDto> meanings,  CardExerciseDto? currentExercise)?  $default,) {final _that = this;
switch (_that) {
case _StudyQueueItemDto() when $default != null:
return $default(_that.cardId,_that.term,_that.phonetic,_that.audioUrl,_that.masteryLevel,_that.state,_that.lapsesCount,_that.isLeech,_that.meanings,_that.currentExercise);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyQueueItemDto extends StudyQueueItemDto {
  const _StudyQueueItemDto({required this.cardId, required this.term, this.phonetic, this.audioUrl, this.masteryLevel = 0, this.state = 'NEW', this.lapsesCount = 0, this.isLeech = false, final  List<MeaningDto> meanings = const [], this.currentExercise}): _meanings = meanings,super._();
  factory _StudyQueueItemDto.fromJson(Map<String, dynamic> json) => _$StudyQueueItemDtoFromJson(json);

@override final  String cardId;
@override final  String term;
@override final  String? phonetic;
@override final  String? audioUrl;
@override@JsonKey() final  int masteryLevel;
@override@JsonKey() final  String state;
@override@JsonKey() final  int lapsesCount;
@override@JsonKey() final  bool isLeech;
 final  List<MeaningDto> _meanings;
@override@JsonKey() List<MeaningDto> get meanings {
  if (_meanings is EqualUnmodifiableListView) return _meanings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_meanings);
}

@override final  CardExerciseDto? currentExercise;

/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyQueueItemDtoCopyWith<_StudyQueueItemDto> get copyWith => __$StudyQueueItemDtoCopyWithImpl<_StudyQueueItemDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyQueueItemDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyQueueItemDto&&(identical(other.cardId, cardId) || other.cardId == cardId)&&(identical(other.term, term) || other.term == term)&&(identical(other.phonetic, phonetic) || other.phonetic == phonetic)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.masteryLevel, masteryLevel) || other.masteryLevel == masteryLevel)&&(identical(other.state, state) || other.state == state)&&(identical(other.lapsesCount, lapsesCount) || other.lapsesCount == lapsesCount)&&(identical(other.isLeech, isLeech) || other.isLeech == isLeech)&&const DeepCollectionEquality().equals(other._meanings, _meanings)&&(identical(other.currentExercise, currentExercise) || other.currentExercise == currentExercise));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardId,term,phonetic,audioUrl,masteryLevel,state,lapsesCount,isLeech,const DeepCollectionEquality().hash(_meanings),currentExercise);

@override
String toString() {
  return 'StudyQueueItemDto(cardId: $cardId, term: $term, phonetic: $phonetic, audioUrl: $audioUrl, masteryLevel: $masteryLevel, state: $state, lapsesCount: $lapsesCount, isLeech: $isLeech, meanings: $meanings, currentExercise: $currentExercise)';
}


}

/// @nodoc
abstract mixin class _$StudyQueueItemDtoCopyWith<$Res> implements $StudyQueueItemDtoCopyWith<$Res> {
  factory _$StudyQueueItemDtoCopyWith(_StudyQueueItemDto value, $Res Function(_StudyQueueItemDto) _then) = __$StudyQueueItemDtoCopyWithImpl;
@override @useResult
$Res call({
 String cardId, String term, String? phonetic, String? audioUrl, int masteryLevel, String state, int lapsesCount, bool isLeech, List<MeaningDto> meanings, CardExerciseDto? currentExercise
});


@override $CardExerciseDtoCopyWith<$Res>? get currentExercise;

}
/// @nodoc
class __$StudyQueueItemDtoCopyWithImpl<$Res>
    implements _$StudyQueueItemDtoCopyWith<$Res> {
  __$StudyQueueItemDtoCopyWithImpl(this._self, this._then);

  final _StudyQueueItemDto _self;
  final $Res Function(_StudyQueueItemDto) _then;

/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardId = null,Object? term = null,Object? phonetic = freezed,Object? audioUrl = freezed,Object? masteryLevel = null,Object? state = null,Object? lapsesCount = null,Object? isLeech = null,Object? meanings = null,Object? currentExercise = freezed,}) {
  return _then(_StudyQueueItemDto(
cardId: null == cardId ? _self.cardId : cardId // ignore: cast_nullable_to_non_nullable
as String,term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,phonetic: freezed == phonetic ? _self.phonetic : phonetic // ignore: cast_nullable_to_non_nullable
as String?,audioUrl: freezed == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String?,masteryLevel: null == masteryLevel ? _self.masteryLevel : masteryLevel // ignore: cast_nullable_to_non_nullable
as int,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,lapsesCount: null == lapsesCount ? _self.lapsesCount : lapsesCount // ignore: cast_nullable_to_non_nullable
as int,isLeech: null == isLeech ? _self.isLeech : isLeech // ignore: cast_nullable_to_non_nullable
as bool,meanings: null == meanings ? _self._meanings : meanings // ignore: cast_nullable_to_non_nullable
as List<MeaningDto>,currentExercise: freezed == currentExercise ? _self.currentExercise : currentExercise // ignore: cast_nullable_to_non_nullable
as CardExerciseDto?,
  ));
}

/// Create a copy of StudyQueueItemDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CardExerciseDtoCopyWith<$Res>? get currentExercise {
    if (_self.currentExercise == null) {
    return null;
  }

  return $CardExerciseDtoCopyWith<$Res>(_self.currentExercise!, (value) {
    return _then(_self.copyWith(currentExercise: value));
  });
}
}


/// @nodoc
mixin _$StudyQueueResponseDto {

 int get totalDue; List<StudyQueueItemDto> get queue;
/// Create a copy of StudyQueueResponseDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyQueueResponseDtoCopyWith<StudyQueueResponseDto> get copyWith => _$StudyQueueResponseDtoCopyWithImpl<StudyQueueResponseDto>(this as StudyQueueResponseDto, _$identity);

  /// Serializes this StudyQueueResponseDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyQueueResponseDto&&(identical(other.totalDue, totalDue) || other.totalDue == totalDue)&&const DeepCollectionEquality().equals(other.queue, queue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDue,const DeepCollectionEquality().hash(queue));

@override
String toString() {
  return 'StudyQueueResponseDto(totalDue: $totalDue, queue: $queue)';
}


}

/// @nodoc
abstract mixin class $StudyQueueResponseDtoCopyWith<$Res>  {
  factory $StudyQueueResponseDtoCopyWith(StudyQueueResponseDto value, $Res Function(StudyQueueResponseDto) _then) = _$StudyQueueResponseDtoCopyWithImpl;
@useResult
$Res call({
 int totalDue, List<StudyQueueItemDto> queue
});




}
/// @nodoc
class _$StudyQueueResponseDtoCopyWithImpl<$Res>
    implements $StudyQueueResponseDtoCopyWith<$Res> {
  _$StudyQueueResponseDtoCopyWithImpl(this._self, this._then);

  final StudyQueueResponseDto _self;
  final $Res Function(StudyQueueResponseDto) _then;

/// Create a copy of StudyQueueResponseDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDue = null,Object? queue = null,}) {
  return _then(_self.copyWith(
totalDue: null == totalDue ? _self.totalDue : totalDue // ignore: cast_nullable_to_non_nullable
as int,queue: null == queue ? _self.queue : queue // ignore: cast_nullable_to_non_nullable
as List<StudyQueueItemDto>,
  ));
}

}


/// Adds pattern-matching-related methods to [StudyQueueResponseDto].
extension StudyQueueResponseDtoPatterns on StudyQueueResponseDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyQueueResponseDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyQueueResponseDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyQueueResponseDto value)  $default,){
final _that = this;
switch (_that) {
case _StudyQueueResponseDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyQueueResponseDto value)?  $default,){
final _that = this;
switch (_that) {
case _StudyQueueResponseDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDue,  List<StudyQueueItemDto> queue)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyQueueResponseDto() when $default != null:
return $default(_that.totalDue,_that.queue);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDue,  List<StudyQueueItemDto> queue)  $default,) {final _that = this;
switch (_that) {
case _StudyQueueResponseDto():
return $default(_that.totalDue,_that.queue);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDue,  List<StudyQueueItemDto> queue)?  $default,) {final _that = this;
switch (_that) {
case _StudyQueueResponseDto() when $default != null:
return $default(_that.totalDue,_that.queue);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _StudyQueueResponseDto implements StudyQueueResponseDto {
  const _StudyQueueResponseDto({this.totalDue = 0, final  List<StudyQueueItemDto> queue = const []}): _queue = queue;
  factory _StudyQueueResponseDto.fromJson(Map<String, dynamic> json) => _$StudyQueueResponseDtoFromJson(json);

@override@JsonKey() final  int totalDue;
 final  List<StudyQueueItemDto> _queue;
@override@JsonKey() List<StudyQueueItemDto> get queue {
  if (_queue is EqualUnmodifiableListView) return _queue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_queue);
}


/// Create a copy of StudyQueueResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyQueueResponseDtoCopyWith<_StudyQueueResponseDto> get copyWith => __$StudyQueueResponseDtoCopyWithImpl<_StudyQueueResponseDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$StudyQueueResponseDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyQueueResponseDto&&(identical(other.totalDue, totalDue) || other.totalDue == totalDue)&&const DeepCollectionEquality().equals(other._queue, _queue));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDue,const DeepCollectionEquality().hash(_queue));

@override
String toString() {
  return 'StudyQueueResponseDto(totalDue: $totalDue, queue: $queue)';
}


}

/// @nodoc
abstract mixin class _$StudyQueueResponseDtoCopyWith<$Res> implements $StudyQueueResponseDtoCopyWith<$Res> {
  factory _$StudyQueueResponseDtoCopyWith(_StudyQueueResponseDto value, $Res Function(_StudyQueueResponseDto) _then) = __$StudyQueueResponseDtoCopyWithImpl;
@override @useResult
$Res call({
 int totalDue, List<StudyQueueItemDto> queue
});




}
/// @nodoc
class __$StudyQueueResponseDtoCopyWithImpl<$Res>
    implements _$StudyQueueResponseDtoCopyWith<$Res> {
  __$StudyQueueResponseDtoCopyWithImpl(this._self, this._then);

  final _StudyQueueResponseDto _self;
  final $Res Function(_StudyQueueResponseDto) _then;

/// Create a copy of StudyQueueResponseDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDue = null,Object? queue = null,}) {
  return _then(_StudyQueueResponseDto(
totalDue: null == totalDue ? _self.totalDue : totalDue // ignore: cast_nullable_to_non_nullable
as int,queue: null == queue ? _self._queue : queue // ignore: cast_nullable_to_non_nullable
as List<StudyQueueItemDto>,
  ));
}


}

// dart format on
