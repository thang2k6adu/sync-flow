import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class SubmitStudyUseCase {
  final VocabRepository repository;

  SubmitStudyUseCase(this.repository);

  Future<Either<Failure, StudySubmitResult>> call({
    required String cardId,
    required int masteryLevel,
    required int timeSpentMs,
    required int mistakesCount,
    required bool usedHint,
    String? manualRating,
    required bool isCram,
  }) {
    if (cardId.trim().isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Card ID không được để trống')),
      );
    }

    return repository.submitStudy(
      cardId: cardId.trim(),
      masteryLevel: masteryLevel,
      timeSpentMs: timeSpentMs < 0 ? 0 : timeSpentMs,
      mistakesCount: mistakesCount < 0 ? 0 : mistakesCount,
      usedHint: usedHint,
      manualRating: manualRating,
      isCram: isCram,
    );
  }
}
