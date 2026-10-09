import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/datasources/remote/gamification_remote_datasource.dart';
import 'package:pp191225/data/models/gamification/leaderboard_dto.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/gamification_repository.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

class GamificationRepositoryImpl implements GamificationRepository {
  final GamificationRemoteDataSource remoteDataSource;

  GamificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, UserProgression>> getProgression() async {
    try {
      final res = await remoteDataSource.getProgression();
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      final d = res.data!;
      return Right(UserProgression(
        level: d.level,
        currentExp: d.currentExp,
        totalExp: d.totalExp,
        streak: d.streak,
        lastStudyDate: d.lastStudyDate,
        wordsMastered: d.wordsMastered,
        totalReviews: d.totalReviews,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProgression>> syncProgression({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  }) async {
    try {
      final res = await remoteDataSource.addProgression(
        expGained: expGained,
        cardStudied: cardStudied,
        wordMastered: wordMastered,
        correctExercise: correctExercise,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      final d = res.data!;
      return Right(UserProgression(
        level: d.level,
        currentExp: d.currentExp,
        totalExp: d.totalExp,
        streak: d.streak,
        lastStudyDate: d.lastStudyDate,
        wordsMastered: d.wordsMastered,
        totalReviews: d.totalReviews,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, LeaderboardData>> getLeaderboard({int limit = 20}) async {
    try {
      final res = await remoteDataSource.getLeaderboard(limit: limit);
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      final d = res.data!;
      LeaderboardEntry mapEntry(LeaderboardEntryDto e) => LeaderboardEntry(
            rank: e.rank,
            id: e.id,
            name: e.name,
            avatar: e.avatar,
            exp: e.exp,
            masteredWords: e.masteredWords,
            streak: e.streak,
            rankTitle: e.rankTitle.isEmpty ? 'Tập Sự (Novice)' : e.rankTitle,
            isCurrentUser: e.isCurrentUser,
          );
      return Right(LeaderboardData(
        topThree: d.topThree.map(mapEntry).toList(),
        myStanding: d.myStanding == null ? null : mapEntry(d.myStanding!),
        restList: d.restList.map(mapEntry).toList(),
        totalMembers: d.totalMembers,
      ));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
