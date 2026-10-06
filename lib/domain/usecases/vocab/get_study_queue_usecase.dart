import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class GetStudyQueueUseCase {
  final VocabRepository repository;

  GetStudyQueueUseCase(this.repository);

  Future<Either<Failure, List<StudyItem>>> call({
    String? deckId,
    int limit = 20,
  }) {
    return repository.getStudyQueue(
      deckId: deckId?.trim().isEmpty == true ? null : deckId?.trim(),
      limit: limit > 0 ? limit : 20,
    );
  }
}
