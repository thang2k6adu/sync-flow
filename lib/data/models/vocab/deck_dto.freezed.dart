// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'deck_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DeckDto {

 String get id; String? get userId; String get name; String? get description; String? get category; String? get iconUrl; String? get cefrLevel; bool get isSystem; int get cardCount; DateTime? get createdAt;
/// Create a copy of DeckDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DeckDtoCopyWith<DeckDto> get copyWith => _$DeckDtoCopyWithImpl<DeckDto>(this as DeckDto, _$identity);

  /// Serializes this DeckDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DeckDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.cefrLevel, cefrLevel) || other.cefrLevel == cefrLevel)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,category,iconUrl,cefrLevel,isSystem,cardCount,createdAt);

@override
String toString() {
  return 'DeckDto(id: $id, userId: $userId, name: $name, description: $description, category: $category, iconUrl: $iconUrl, cefrLevel: $cefrLevel, isSystem: $isSystem, cardCount: $cardCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $DeckDtoCopyWith<$Res>  {
  factory $DeckDtoCopyWith(DeckDto value, $Res Function(DeckDto) _then) = _$DeckDtoCopyWithImpl;
@useResult
$Res call({
 String id, String? userId, String name, String? description, String? category, String? iconUrl, String? cefrLevel, bool isSystem, int cardCount, DateTime? createdAt
});




}
/// @nodoc
class _$DeckDtoCopyWithImpl<$Res>
    implements $DeckDtoCopyWith<$Res> {
  _$DeckDtoCopyWithImpl(this._self, this._then);

  final DeckDto _self;
  final $Res Function(DeckDto) _then;

/// Create a copy of DeckDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? name = null,Object? description = freezed,Object? category = freezed,Object? iconUrl = freezed,Object? cefrLevel = freezed,Object? isSystem = null,Object? cardCount = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,cefrLevel: freezed == cefrLevel ? _self.cefrLevel : cefrLevel // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [DeckDto].
extension DeckDtoPatterns on DeckDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DeckDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DeckDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DeckDto value)  $default,){
final _that = this;
switch (_that) {
case _DeckDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DeckDto value)?  $default,){
final _that = this;
switch (_that) {
case _DeckDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? userId,  String name,  String? description,  String? category,  String? iconUrl,  String? cefrLevel,  bool isSystem,  int cardCount,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DeckDto() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.category,_that.iconUrl,_that.cefrLevel,_that.isSystem,_that.cardCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? userId,  String name,  String? description,  String? category,  String? iconUrl,  String? cefrLevel,  bool isSystem,  int cardCount,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _DeckDto():
return $default(_that.id,_that.userId,_that.name,_that.description,_that.category,_that.iconUrl,_that.cefrLevel,_that.isSystem,_that.cardCount,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? userId,  String name,  String? description,  String? category,  String? iconUrl,  String? cefrLevel,  bool isSystem,  int cardCount,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _DeckDto() when $default != null:
return $default(_that.id,_that.userId,_that.name,_that.description,_that.category,_that.iconUrl,_that.cefrLevel,_that.isSystem,_that.cardCount,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DeckDto extends DeckDto {
  const _DeckDto({required this.id, this.userId, required this.name, this.description, this.category, this.iconUrl, this.cefrLevel, this.isSystem = false, this.cardCount = 0, this.createdAt}): super._();
  factory _DeckDto.fromJson(Map<String, dynamic> json) => _$DeckDtoFromJson(json);

@override final  String id;
@override final  String? userId;
@override final  String name;
@override final  String? description;
@override final  String? category;
@override final  String? iconUrl;
@override final  String? cefrLevel;
@override@JsonKey() final  bool isSystem;
@override@JsonKey() final  int cardCount;
@override final  DateTime? createdAt;

/// Create a copy of DeckDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeckDtoCopyWith<_DeckDto> get copyWith => __$DeckDtoCopyWithImpl<_DeckDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DeckDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeckDto&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.cefrLevel, cefrLevel) || other.cefrLevel == cefrLevel)&&(identical(other.isSystem, isSystem) || other.isSystem == isSystem)&&(identical(other.cardCount, cardCount) || other.cardCount == cardCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,name,description,category,iconUrl,cefrLevel,isSystem,cardCount,createdAt);

@override
String toString() {
  return 'DeckDto(id: $id, userId: $userId, name: $name, description: $description, category: $category, iconUrl: $iconUrl, cefrLevel: $cefrLevel, isSystem: $isSystem, cardCount: $cardCount, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$DeckDtoCopyWith<$Res> implements $DeckDtoCopyWith<$Res> {
  factory _$DeckDtoCopyWith(_DeckDto value, $Res Function(_DeckDto) _then) = __$DeckDtoCopyWithImpl;
@override @useResult
$Res call({
 String id, String? userId, String name, String? description, String? category, String? iconUrl, String? cefrLevel, bool isSystem, int cardCount, DateTime? createdAt
});




}
/// @nodoc
class __$DeckDtoCopyWithImpl<$Res>
    implements _$DeckDtoCopyWith<$Res> {
  __$DeckDtoCopyWithImpl(this._self, this._then);

  final _DeckDto _self;
  final $Res Function(_DeckDto) _then;

/// Create a copy of DeckDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? name = null,Object? description = freezed,Object? category = freezed,Object? iconUrl = freezed,Object? cefrLevel = freezed,Object? isSystem = null,Object? cardCount = null,Object? createdAt = freezed,}) {
  return _then(_DeckDto(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String?,iconUrl: freezed == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String?,cefrLevel: freezed == cefrLevel ? _self.cefrLevel : cefrLevel // ignore: cast_nullable_to_non_nullable
as String?,isSystem: null == isSystem ? _self.isSystem : isSystem // ignore: cast_nullable_to_non_nullable
as bool,cardCount: null == cardCount ? _self.cardCount : cardCount // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
