import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/datasources/remote/vocab_remote_datasource.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/vocab/deck_dto.dart';
import 'package:pp191225/data/models/vocab/card_dto.dart';
import 'package:pp191225/data/models/vocab/study_queue_dto.dart';
import 'package:pp191225/data/models/vocab/study_submit_dto.dart';
import 'package:pp191225/data/services/api_service.dart';

class VocabRemoteDataSourceImpl implements VocabRemoteDataSource {
  final ApiService apiService;

  VocabRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<List<DeckDto>>> getDecks() async {
    try {
      final response = await apiService.get(ApiEndpoints.decks);
      return ApiResponse<List<DeckDto>>.fromJson(
        response as Map<String, dynamic>,
        (data) => (data as List<dynamic>)
            .map((item) => DeckDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return ApiResponse<List<DeckDto>>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<DeckDto>> getDeck(String id) async {
    try {
      final response = await apiService.get(ApiEndpoints.getDeckById(id));
      return ApiResponse<DeckDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => DeckDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<DeckDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<DeckDto>> createDeck({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  }) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.decks,
        data: {
          'name': name,
          if (description != null) 'description': description,
          if (category != null) 'category': category,
          if (iconUrl != null) 'iconUrl': iconUrl,
          if (cefrLevel != null) 'cefrLevel': cefrLevel,
        },
      );
      return ApiResponse<DeckDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => DeckDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<DeckDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<Map<String, dynamic>>> deleteDeck(String id) async {
    try {
      final response = await apiService.delete(ApiEndpoints.getDeckById(id));
      return ApiResponse<Map<String, dynamic>>.fromJson(
        response as Map<String, dynamic>,
        (data) => (data as Map<String, dynamic>?) ?? {},
      );
    } catch (e) {
      return ApiResponse<Map<String, dynamic>>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<List<CardDto>>> getCardsByDeck(String deckId) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.cards,
        queryParameters: {'deckId': deckId},
      );
      return ApiResponse<List<CardDto>>.fromJson(
        response as Map<String, dynamic>,
        (data) => (data as List<dynamic>)
            .map((item) => CardDto.fromJson(item as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      return ApiResponse<List<CardDto>>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<CardDto>> getCard(String id) async {
    try {
      final response = await apiService.get(ApiEndpoints.getCardById(id));
      return ApiResponse<CardDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => CardDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<CardDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
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
  }) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.cards,
        data: {
          'deckId': deckId,
          'term': term,
          if (phonetic != null) 'phonetic': phonetic,
          if (audioUrl != null) 'audioUrl': audioUrl,
          if (cefrLevel != null) 'cefrLevel': cefrLevel,
          if (frequencyRank != null) 'frequencyRank': frequencyRank,
          if (wordFamilyId != null) 'wordFamilyId': wordFamilyId,
          if (tagIds != null) 'tagIds': tagIds,
          if (meanings != null) 'meanings': meanings,
          if (collocations != null) 'collocations': collocations,
          if (exercises != null) 'exercises': exercises,
        },
      );
      return ApiResponse<CardDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => CardDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<CardDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<StudyQueueResponseDto>> getStudyQueue({
    int limit = 20,
    int page = 0,
  }) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.studyQueue,
        queryParameters: {
          'limit': limit,
          'page': page,
        },
      );
      return ApiResponse<StudyQueueResponseDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => StudyQueueResponseDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<StudyQueueResponseDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<StudyQueueResponseDto>> getDeckQueue({
    required String deckId,
    int limit = 20,
    int page = 0,
  }) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.getDeckStudyQueue(deckId),
        queryParameters: {
          'limit': limit,
          'page': page,
        },
      );
      return ApiResponse<StudyQueueResponseDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => StudyQueueResponseDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<StudyQueueResponseDto>(
        error: true,
        message: e.toString(),
      );
    }
  }

  @override
  Future<ApiResponse<StudySubmitDto>> submitStudy({
    required String cardId,
    required int masteryLevel,
    required int timeSpentMs,
    required int mistakesCount,
    required bool usedHint,
    String? manualRating,
    required bool isCram,
  }) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.studySubmit,
        data: {
          'cardId': cardId,
          'masteryLevel': masteryLevel,
          'timeSpentMs': timeSpentMs,
          'mistakesCount': mistakesCount,
          'usedHint': usedHint,
          if (manualRating != null) 'manualRating': manualRating,
          'isCram': isCram,
        },
      );
      return ApiResponse<StudySubmitDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => StudySubmitDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<StudySubmitDto>(
        error: true,
        message: e.toString(),
      );
    }
  }
}
