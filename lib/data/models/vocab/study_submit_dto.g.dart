// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_submit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_StudySubmitDto _$StudySubmitDtoFromJson(Map<String, dynamic> json) =>
    _StudySubmitDto(
      cardId: json['cardId'] as String,
      evaluatedRating: json['evaluatedRating'] as String,
      previousLevel: (json['previousLevel'] as num?)?.toInt() ?? 0,
      newLevel: (json['newLevel'] as num?)?.toInt() ?? 0,
      previousInterval: (json['previousInterval'] as num?)?.toInt() ?? 0,
      newInterval: (json['newInterval'] as num?)?.toInt() ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble(),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      isLeech: json['isLeech'] as bool? ?? false,
    );

Map<String, dynamic> _$StudySubmitDtoToJson(_StudySubmitDto instance) =>
    <String, dynamic>{
      'cardId': instance.cardId,
      'evaluatedRating': instance.evaluatedRating,
      'previousLevel': instance.previousLevel,
      'newLevel': instance.newLevel,
      'previousInterval': instance.previousInterval,
      'newInterval': instance.newInterval,
      'easeFactor': instance.easeFactor,
      'dueDate': instance.dueDate?.toIso8601String(),
      'isLeech': instance.isLeech,
    };
