import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';

part 'study_submit_dto.freezed.dart';
part 'study_submit_dto.g.dart';

@freezed
abstract class StudySubmitDto with _$StudySubmitDto {
  const StudySubmitDto._();

  const factory StudySubmitDto({
    required String cardId,
    required String evaluatedRating,
    @Default(0) int previousLevel,
    @Default(0) int newLevel,
    @Default(0) int previousInterval,
    @Default(0) int newInterval,
    double? easeFactor,
    DateTime? dueDate,
    @Default(false) bool isLeech,
  }) = _StudySubmitDto;

  factory StudySubmitDto.fromJson(Map<String, dynamic> json) =>
      _$StudySubmitDtoFromJson(json);

  StudySubmitResult toEntity() {
    return StudySubmitResult(
      cardId: cardId,
      evaluatedRating: evaluatedRating,
      previousLevel: previousLevel,
      newLevel: newLevel,
      previousInterval: previousInterval,
      newInterval: newInterval,
      easeFactor: easeFactor,
      dueDate: dueDate?.toLocal(),
      isLeech: isLeech,
    );
  }
}
