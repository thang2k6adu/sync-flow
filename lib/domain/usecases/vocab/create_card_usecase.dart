import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class CreateCardUseCase {
  final VocabRepository repository;

  CreateCardUseCase(this.repository);

  Future<Either<Failure, VocabCard>> call({
    required String deckId,
    required String term,
    String? phonetic,
    String? audioUrl,
    String? cefrLevel,
    int? frequencyRank,
    String? wordFamilyId,
    List<String>? tagIds,
    List<Map<String, dynamic>>? meanings,
    List<String>? collocations,
    List<Map<String, dynamic>>? exercises,
  }) {
    final cleanTerm = term.trim();
    if (cleanTerm.isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Từ vựng không được để trống')),
      );
    }
    if (deckId.trim().isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Deck ID không được để trống')),
      );
    }

    return repository.createCard(
      deckId: deckId.trim(),
      term: cleanTerm,
      phonetic: phonetic?.trim().isEmpty == true ? null : phonetic?.trim(),
      audioUrl: audioUrl?.trim().isEmpty == true ? null : audioUrl?.trim(),
      cefrLevel: cefrLevel?.trim().isEmpty == true ? null : cefrLevel?.trim(),
      frequencyRank: frequencyRank,
      wordFamilyId: wordFamilyId?.trim().isEmpty == true ? null : wordFamilyId?.trim(),
      tagIds: tagIds,
      meanings: meanings,
      collocations: collocations,
      exercises: exercises,
    );
  }
}
