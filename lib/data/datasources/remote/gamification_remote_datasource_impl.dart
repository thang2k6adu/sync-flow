import 'package:pp191225/core/constants/api_endpoints.dart';
import 'package:pp191225/data/datasources/remote/gamification_remote_datasource.dart';
import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/gamification/leaderboard_dto.dart';
import 'package:pp191225/data/services/api_service.dart';

class GamificationRemoteDataSourceImpl implements GamificationRemoteDataSource {
  final ApiService apiService;

  GamificationRemoteDataSourceImpl(this.apiService);

  @override
  Future<ApiResponse<ProgressionDto>> getProgression() async {
    try {
      final response = await apiService.get(ApiEndpoints.userProgression);
      return ApiResponse<ProgressionDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => ProgressionDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<ProgressionDto>(error: true, message: e.toString());
    }
  }

  @override
  Future<ApiResponse<ProgressionDto>> addProgression({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  }) async {
    try {
      final response = await apiService.post(
        ApiEndpoints.userProgressionAdd,
        data: {
          if (expGained != null) 'expGained': expGained,
          if (cardStudied != null) 'cardStudied': cardStudied,
          if (wordMastered != null) 'wordMastered': wordMastered,
          if (correctExercise != null) 'correctExercise': correctExercise,
        },
      );
      return ApiResponse<ProgressionDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => ProgressionDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<ProgressionDto>(error: true, message: e.toString());
    }
  }

  @override
  Future<ApiResponse<LeaderboardResponseDto>> getLeaderboard({int limit = 20}) async {
    try {
      final response = await apiService.get(
        ApiEndpoints.leaderboard,
        queryParameters: {'limit': limit},
      );
      return ApiResponse<LeaderboardResponseDto>.fromJson(
        response as Map<String, dynamic>,
        (data) => LeaderboardResponseDto.fromJson(data as Map<String, dynamic>),
      );
    } catch (e) {
      return ApiResponse<LeaderboardResponseDto>(error: true, message: e.toString());
    }
  }
}
