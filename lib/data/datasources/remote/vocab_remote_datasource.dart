import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/vocab/deck_dto.dart';
import 'package:pp191225/data/models/vocab/card_dto.dart';
import 'package:pp191225/data/models/vocab/study_queue_dto.dart';
import 'package:pp191225/data/models/vocab/study_submit_dto.dart';

abstract class VocabRemoteDataSource {
  Future<ApiResponse<List<DeckDto>>> getDecks();

  Future<ApiResponse<DeckDto>> getDeck(String id);

  Future<ApiResponse<DeckDto>> createDeck({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  });

  Future<ApiResponse<Map<String, dynamic>>> deleteDeck(String id);

  Future<ApiResponse<List<CardDto>>> getCardsByDeck(String deckId);

  Future<ApiResponse<CardDto>> getCard(String id);

  Future<ApiResponse<CardDto>> createCard({
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

  Future<ApiResponse<StudyQueueResponseDto>> getStudyQueue({
    int limit = 20,
    int page = 0,
  });

  Future<ApiResponse<StudyQueueResponseDto>> getDeckQueue({
    required String deckId,
    int limit = 20,
    int page = 0,
  });

  Future<ApiResponse<StudySubmitDto>> submitStudy({
    required String cardId,
    required int masteryLevel,
    required int timeSpentMs,
    required int mistakesCount,
    required bool usedHint,
    String? manualRating,
    required bool isCram,
  });
}
