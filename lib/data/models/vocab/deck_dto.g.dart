// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deck_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DeckDto _$DeckDtoFromJson(Map<String, dynamic> json) => _DeckDto(
  id: json['id'] as String,
  userId: json['userId'] as String?,
  name: json['name'] as String,
  description: json['description'] as String?,
  category: json['category'] as String?,
  iconUrl: json['iconUrl'] as String?,
  cefrLevel: json['cefrLevel'] as String?,
  isSystem: json['isSystem'] as bool? ?? false,
  cardCount: (json['cardCount'] as num?)?.toInt() ?? 0,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$DeckDtoToJson(_DeckDto instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'iconUrl': instance.iconUrl,
  'cefrLevel': instance.cefrLevel,
  'isSystem': instance.isSystem,
  'cardCount': instance.cardCount,
  'createdAt': instance.createdAt?.toIso8601String(),
};
