// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_exercise_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CardExerciseDto _$CardExerciseDtoFromJson(Map<String, dynamic> json) =>
    _CardExerciseDto(
      id: json['id'] as String?,
      cardId: json['cardId'] as String?,
      exerciseType: json['exerciseType'] as String? ?? 'fill_blank',
      meaningHint: json['meaningHint'] as String?,
      targetSentence: json['targetSentence'] as String,
      vietnameseTranslation: json['vietnameseTranslation'] as String?,
      tokens:
          (json['tokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      distractorTokens:
          (json['distractorTokens'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      targetIndex: (json['targetIndex'] as num?)?.toInt() ?? 0,
      audioUrl: json['audioUrl'] as String?,
    );

Map<String, dynamic> _$CardExerciseDtoToJson(_CardExerciseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cardId': instance.cardId,
      'exerciseType': instance.exerciseType,
      'meaningHint': instance.meaningHint,
      'targetSentence': instance.targetSentence,
      'vietnameseTranslation': instance.vietnameseTranslation,
      'tokens': instance.tokens,
      'distractorTokens': instance.distractorTokens,
      'targetIndex': instance.targetIndex,
      'audioUrl': instance.audioUrl,
    };
