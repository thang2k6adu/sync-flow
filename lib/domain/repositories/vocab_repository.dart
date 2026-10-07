import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';
import 'package:pp191225/domain/failures/failures.dart';

abstract class VocabRepository {
  Future<Either<Failure, List<Deck>>> getDecks();

  Future<Either<Failure, Deck>> getDeck(String id);

  Future<Either<Failure, Deck>> createDeck({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  });

  Future<Either<Failure, void>> deleteDeck(String id);

  Future<Either<Failure, List<VocabCard>>> getCardsByDeck(String deckId);

  Future<Either<Failure, VocabCard>> getCard(String id);

  Future<Either<Failure, VocabCard>> createCard({
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
  });

  Future<Either<Failure, List<StudyItem>>> getStudyQueue({
    int limit = 20,
    int page = 0,
  });

  Future<Either<Failure, List<StudyItem>>> getDeckQueue({
    required String deckId,
    int limit = 20,
    int page = 0,
  });

  Future<Either<Failure, StudySubmitResult>> submitStudy({
    required String cardId,
    required int masteryLevel,
    required int timeSpentMs,
    required int mistakesCount,
    required bool usedHint,
    String? manualRating,
    required bool isCram,
  });
}
