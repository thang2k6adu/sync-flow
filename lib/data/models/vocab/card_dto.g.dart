// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardDto _$CardDtoFromJson(Map<String, dynamic> json) => _CardDto(
  id: json['id'] as String,
  deckId: json['deckId'] as String,
  term: json['term'] as String,
  phonetic: json['phonetic'] as String?,
  audioUrl: json['audioUrl'] as String?,
  cefrLevel: json['cefrLevel'] as String?,
  frequencyRank: (json['frequencyRank'] as num?)?.toInt(),
  wordFamilyId: json['wordFamilyId'] as String?,
  tagIds:
      (json['tagIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  meanings:
      (json['meanings'] as List<dynamic>?)
          ?.map((e) => MeaningDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  collocations:
      (json['collocations'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  exercises:
      (json['exercises'] as List<dynamic>?)
          ?.map((e) => CardExerciseDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$CardDtoToJson(_CardDto instance) => <String, dynamic>{
  'id': instance.id,
  'deckId': instance.deckId,
  'term': instance.term,
  'phonetic': instance.phonetic,
  'audioUrl': instance.audioUrl,
  'cefrLevel': instance.cefrLevel,
  'frequencyRank': instance.frequencyRank,
  'wordFamilyId': instance.wordFamilyId,
  'tagIds': instance.tagIds,
  'meanings': instance.meanings,
  'collocations': instance.collocations,
  'exercises': instance.exercises,
};
