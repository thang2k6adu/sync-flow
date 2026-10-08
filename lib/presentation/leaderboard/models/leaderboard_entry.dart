class LeaderboardEntry {
  final int rank;
  final String id;
  final String name;
  final String? avatar;
  final int exp;
  final int masteredWords;
  final int streak;
  final String rankTitle;
  final int rankDiff; // ví dụ +12 bậc, -2 bậc
  final bool isCurrentUser;

  const LeaderboardEntry({
    required this.rank,
    required this.id,
    required this.name,
    this.avatar,
    required this.exp,
    this.masteredWords = 0,
    this.streak = 1,
    required this.rankTitle,
    this.rankDiff = 0,
    this.isCurrentUser = false,
  });

  LeaderboardEntry copyWith({
    int? rank,
    String? id,
    String? name,
    String? avatar,
    int? exp,
    int? masteredWords,
    int? streak,
    String? rankTitle,
    int? rankDiff,
    bool? isCurrentUser,
  }) {
    return LeaderboardEntry(
      rank: rank ?? this.rank,
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      exp: exp ?? this.exp,
      masteredWords: masteredWords ?? this.masteredWords,
      streak: streak ?? this.streak,
      rankTitle: rankTitle ?? this.rankTitle,
      rankDiff: rankDiff ?? this.rankDiff,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}
