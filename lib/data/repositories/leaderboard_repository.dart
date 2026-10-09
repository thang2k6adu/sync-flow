import 'package:pp191225/data/models/base/api_response.dart';
import 'package:pp191225/data/models/gamification/leaderboard_dto.dart';
import 'package:pp191225/data/services/api_service.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

class LeaderboardData {
  final List<LeaderboardEntry> topThree;
  final LeaderboardEntry? myStanding;
  final List<LeaderboardEntry> restList;

  const LeaderboardData({
    this.topThree = const [],
    this.myStanding,
    this.restList = const [],
  });
}

/// Read-only leaderboard access; does not update learning progression.
class LeaderboardRepository {
  final ApiService apiService;

  LeaderboardRepository(this.apiService);

  Future<LeaderboardData> getLeaderboard() async {
    final response = await apiService.get(
      '/users/leaderboard',
      queryParameters: {'limit': 20},
    );
    final result = ApiResponse<LeaderboardResponseDto>.fromJson(
      response as Map<String, dynamic>,
      (data) => LeaderboardResponseDto.fromJson(data as Map<String, dynamic>),
    );
    if (result.error || result.data == null) {
      throw Exception(
        result.error ? result.message : 'Thiếu dữ liệu bảng xếp hạng',
      );
    }
    final data = result.data!;
    LeaderboardEntry mapEntry(LeaderboardEntryDto entry) => LeaderboardEntry(
      rank: entry.rank,
      id: entry.id,
      name: entry.name,
      avatar: entry.avatar,
      exp: entry.exp,
      masteredWords: entry.masteredWords,
      streak: entry.streak,
      rankTitle: entry.rankTitle.isEmpty ? 'Tập Sự (Novice)' : entry.rankTitle,
      isCurrentUser: entry.isCurrentUser,
    );
    return LeaderboardData(
      topThree: data.topThree.map(mapEntry).toList(),
      myStanding: data.myStanding == null ? null : mapEntry(data.myStanding!),
      restList: data.restList.map(mapEntry).toList(),
    );
  }
}
