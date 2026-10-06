import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/card_exercise.dart';

part 'card_exercise_dto.freezed.dart';
part 'card_exercise_dto.g.dart';

@freezed
abstract class CardExerciseDto with _$CardExerciseDto {
  const CardExerciseDto._();

  const factory CardExerciseDto({
    String? id,
    String? cardId,
    @Default('fill_blank') String exerciseType,
    String? meaningHint,
    required String targetSentence,
    String? vietnameseTranslation,
    @Default([]) List<String> tokens,
    @Default([]) List<String> distractorTokens,
    @Default(0) int targetIndex,
    String? audioUrl,
  }) = _CardExerciseDto;

  factory CardExerciseDto.fromJson(Map<String, dynamic> json) =>
      _$CardExerciseDtoFromJson(json);

  CardExercise toEntity() {
    return CardExercise(
      id: id,
      cardId: cardId,
      exerciseType: exerciseType,
      meaningHint: meaningHint,
      targetSentence: targetSentence,
      vietnameseTranslation: vietnameseTranslation,
      tokens: tokens,
      distractorTokens: distractorTokens,
      targetIndex: targetIndex,
      audioUrl: audioUrl,
    );
  }
}
