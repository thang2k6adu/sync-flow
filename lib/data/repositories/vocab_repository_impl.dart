import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/datasources/remote/vocab_remote_datasource.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class VocabRepositoryImpl implements VocabRepository {
  final VocabRemoteDataSource remoteDataSource;

  VocabRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Deck>>> getDecks() async {
    try {
      final res = await remoteDataSource.getDecks();
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Deck>> getDeck(String id) async {
    try {
      final res = await remoteDataSource.getDeck(id);
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Deck>> createDeck({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  }) async {
    try {
      final res = await remoteDataSource.createDeck(
        name: name,
        description: description,
        category: category,
        iconUrl: iconUrl,
        cefrLevel: cefrLevel,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDeck(String id) async {
    try {
      final res = await remoteDataSource.deleteDeck(id);
      if (res.error) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VocabCard>>> getCardsByDeck(String deckId) async {
    try {
      final res = await remoteDataSource.getCardsByDeck(deckId);
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, VocabCard>> getCard(String id) async {
    try {
      final res = await remoteDataSource.getCard(id);
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
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
  }) async {
    try {
      final res = await remoteDataSource.createCard(
        deckId: deckId,
        term: term,
        phonetic: phonetic,
        audioUrl: audioUrl,
        cefrLevel: cefrLevel,
        frequencyRank: frequencyRank,
        wordFamilyId: wordFamilyId,
        tagIds: tagIds,
        meanings: meanings,
        collocations: collocations,
        exercises: exercises,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudyItem>>> getStudyQueue({
    int limit = 20,
    int page = 0,
  }) async {
    try {
      final res = await remoteDataSource.getStudyQueue(
        limit: limit,
        page: page,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.queue.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StudyItem>>> getDeckQueue({
    required String deckId,
    int limit = 20,
    int page = 0,
  }) async {
    try {
      final res = await remoteDataSource.getDeckQueue(
        deckId: deckId,
        limit: limit,
        page: page,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.queue.map((dto) => dto.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, StudySubmitResult>> submitStudy({
    required String cardId,
    required int masteryLevel,
    required int timeSpentMs,
    required int mistakesCount,
    required bool usedHint,
    String? manualRating,
    required bool isCram,
  }) async {
    try {
      final res = await remoteDataSource.submitStudy(
        cardId: cardId,
        masteryLevel: masteryLevel,
        timeSpentMs: timeSpentMs,
        mistakesCount: mistakesCount,
        usedHint: usedHint,
        manualRating: manualRating,
        isCram: isCram,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
