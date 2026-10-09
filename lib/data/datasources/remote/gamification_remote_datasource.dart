import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/gamification/leaderboard_dto.dart';

/// Gamification remote data source: progression + leaderboard (backend thật).
abstract class GamificationRemoteDataSource {
  Future<ApiResponse<ProgressionDto>> getProgression();

  Future<ApiResponse<ProgressionDto>> addProgression({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  });

  Future<ApiResponse<LeaderboardResponseDto>> getLeaderboard({int limit = 20});
}
