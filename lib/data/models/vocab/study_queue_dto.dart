import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'meaning_dto.dart';
import 'card_exercise_dto.dart';

part 'study_queue_dto.freezed.dart';
part 'study_queue_dto.g.dart';

@freezed
abstract class StudyQueueItemDto with _$StudyQueueItemDto {
  const StudyQueueItemDto._();

  const factory StudyQueueItemDto({
    required String cardId,
    required String term,
    String? phonetic,
    String? audioUrl,
    @Default(0) int masteryLevel,
    @Default('NEW') String state,
    @Default(0) int lapsesCount,
    @Default(false) bool isLeech,
    @Default([]) List<MeaningDto> meanings,
    CardExerciseDto? currentExercise,
  }) = _StudyQueueItemDto;

  factory StudyQueueItemDto.fromJson(Map<String, dynamic> json) =>
      _$StudyQueueItemDtoFromJson(json);

  StudyItem toEntity() {
    return StudyItem(
      cardId: cardId,
      term: term,
      phonetic: phonetic,
      audioUrl: audioUrl,
      masteryLevel: masteryLevel,
      state: state,
      lapsesCount: lapsesCount,
      isLeech: isLeech,
      meanings: meanings.map((m) => m.toEntity()).toList(),
      currentExercise: currentExercise?.toEntity(),
    );
  }
}

@freezed
abstract class StudyQueueResponseDto with _$StudyQueueResponseDto {
  const factory StudyQueueResponseDto({
    @Default(0) int totalDue,
    @Default([]) List<StudyQueueItemDto> queue,
  }) = _StudyQueueResponseDto;

  factory StudyQueueResponseDto.fromJson(Map<String, dynamic> json) =>
      _$StudyQueueResponseDtoFromJson(json);
}
