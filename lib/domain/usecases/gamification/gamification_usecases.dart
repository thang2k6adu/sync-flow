import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/gamification_repository.dart';

class GetLeaderboardUseCase {
  final GamificationRepository repository;

  GetLeaderboardUseCase(this.repository);

  Future<Either<Failure, LeaderboardData>> call({int limit = 20}) {
    return repository.getLeaderboard(limit: limit);
  }
}

class SyncProgressionUseCase {
  final GamificationRepository repository;

  SyncProgressionUseCase(this.repository);

  Future<Either<Failure, UserProgression>> call({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  }) {
    return repository.syncProgression(
      expGained: expGained,
      cardStudied: cardStudied,
      wordMastered: wordMastered,
      correctExercise: correctExercise,
    );
  }
}
