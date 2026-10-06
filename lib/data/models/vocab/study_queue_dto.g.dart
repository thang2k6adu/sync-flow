// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_queue_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudyQueueItemDto _$StudyQueueItemDtoFromJson(Map<String, dynamic> json) =>
    _StudyQueueItemDto(
      cardId: json['cardId'] as String,
      term: json['term'] as String,
      phonetic: json['phonetic'] as String?,
      audioUrl: json['audioUrl'] as String?,
      masteryLevel: (json['masteryLevel'] as num?)?.toInt() ?? 0,
      state: json['state'] as String? ?? 'NEW',
      lapsesCount: (json['lapsesCount'] as num?)?.toInt() ?? 0,
      isLeech: json['isLeech'] as bool? ?? false,
      meanings:
          (json['meanings'] as List<dynamic>?)
              ?.map((e) => MeaningDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentExercise: json['currentExercise'] == null
          ? null
          : CardExerciseDto.fromJson(
              json['currentExercise'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$StudyQueueItemDtoToJson(_StudyQueueItemDto instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'term': instance.term,
      'phonetic': instance.phonetic,
      'audioUrl': instance.audioUrl,
      'masteryLevel': instance.masteryLevel,
      'state': instance.state,
      'lapsesCount': instance.lapsesCount,
      'isLeech': instance.isLeech,
      'meanings': instance.meanings,
      'currentExercise': instance.currentExercise,
    };

_StudyQueueResponseDto _$StudyQueueResponseDtoFromJson(
  Map<String, dynamic> json,
) => _StudyQueueResponseDto(
  totalDue: (json['totalDue'] as num?)?.toInt() ?? 0,
  queue:
      (json['queue'] as List<dynamic>?)
          ?.map((e) => StudyQueueItemDto.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$StudyQueueResponseDtoToJson(
  _StudyQueueResponseDto instance,
) => <String, dynamic>{'totalDue': instance.totalDue, 'queue': instance.queue};
