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
    int page = 0,
  }) {
    final validDeckId = deckId?.trim().isEmpty == true ? null : deckId?.trim();
    final validLimit = limit > 0 ? limit : 20;

    if (validDeckId != null) {
      return repository.getDeckQueue(deckId: validDeckId, limit: validLimit, page: page);
    } else {
      return repository.getStudyQueue(limit: validLimit, page: page);
    }
  }
}
