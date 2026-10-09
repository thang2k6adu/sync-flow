import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

/// Gamification repository: progression + leaderboard từ backend thật.
abstract class GamificationRepository {
  Future<Either<Failure, UserProgression>> getProgression();

  Future<Either<Failure, UserProgression>> syncProgression({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  });

  Future<Either<Failure, LeaderboardData>> getLeaderboard({int limit = 20});
}

/// Dữ liệu BXH đã tách sẵn cho UI hiện tại (top3 / myStanding / restList).
class LeaderboardData {
  final List<LeaderboardEntry> topThree;
  final LeaderboardEntry? myStanding;
  final List<LeaderboardEntry> restList;
  final int totalMembers;

  const LeaderboardData({
    this.topThree = const [],
    this.myStanding,
    this.restList = const [],
    this.totalMembers = 0,
  });
}
