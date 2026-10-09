/// DTO cho 1 dòng bảng xếp hạng từ backend (không dùng codegen để khỏi chạy build_runner).
class LeaderboardEntryDto {
  final int rank;
  final String id;
  final String name;
  final String? avatar;
  final int exp;
  final int masteredWords;
  final int streak;
  final String rankTitle;
  final bool isCurrentUser;

  const LeaderboardEntryDto({
    required this.rank,
    required this.id,
    required this.name,
    this.avatar,
    required this.exp,
    this.masteredWords = 0,
    this.streak = 0,
    required this.rankTitle,
    this.isCurrentUser = false,
  });

  factory LeaderboardEntryDto.fromJson(Map<String, dynamic> json) {
    return LeaderboardEntryDto(
      rank: toInt(json['rank']),
      id: '${json['id'] ?? ''}',
      name: '${json['name'] ?? 'Học viên'}',
      avatar: json['avatar'] as String?,
      exp: toInt(json['exp']),
      masteredWords: toInt(json['masteredWords']),
      streak: toInt(json['streak']),
      rankTitle: '${json['rankTitle'] ?? ''}',
      isCurrentUser: json['isCurrentUser'] == true,
    );
  }

  static int toInt(Object? v) {
    if (v is int) return v;
    if (v is num) return v.toInt();
    return int.tryParse('$v') ?? 0;
  }
}

/// DTO cho response GET /users/leaderboard.
class LeaderboardResponseDto {
  final List<LeaderboardEntryDto> topThree;
  final LeaderboardEntryDto? myStanding;
  final List<LeaderboardEntryDto> restList;
  final int totalMembers;

  const LeaderboardResponseDto({
    this.topThree = const [],
    this.myStanding,
    this.restList = const [],
    this.totalMembers = 0,
  });

  factory LeaderboardResponseDto.fromJson(Map<String, dynamic> json) {
    List<LeaderboardEntryDto> parseList(Object? v) {
      if (v is! List) return const [];
      return v
          .whereType<Map>()
          .map(
            (e) => LeaderboardEntryDto.fromJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    }

    final my = json['myStanding'];
    return LeaderboardResponseDto(
      topThree: parseList(json['topThree']),
      myStanding: my is Map
          ? LeaderboardEntryDto.fromJson(Map<String, dynamic>.from(my))
          : null,
      restList: parseList(json['restList']),
      totalMembers: LeaderboardEntryDto.toInt(json['totalMembers']),
    );
  }
}
