class UserProgression {
  final int level;
  final int currentExp;
  final int totalExp;
  final int streak;
  final DateTime? lastStudyDate;
  final int wordsMastered;
  final int totalReviews;

  const UserProgression({
    this.level = 1,
    this.currentExp = 0,
    this.totalExp = 0,
    this.streak = 1,
    this.lastStudyDate,
    this.wordsMastered = 0,
    this.totalReviews = 0,
  });

  /// Điểm EXP cần có để lên cấp tiếp theo
  int get expToNextLevel => level * 100;

  /// Tiến độ từ 0.0 -> 1.0 đến level kế tiếp
  double get progress {
    if (expToNextLevel <= 0) return 1.0;
    final p = currentExp / expToNextLevel;
    return p.clamp(0.0, 1.0);
  }

  /// Danh hiệu theo cấp độ
  String get rankTitle {
    if (level <= 1) return 'Tập Sự (Novice)';
    if (level == 2) return 'Khám Phá (Explorer)';
    if (level == 3) return 'Tinh Anh (Apprentice)';
    if (level == 4) return 'Chuyên Cần (Scholar)';
    if (level == 5) return 'Học Giả (Expert)';
    return 'Bậc Thầy (Master)';
  }

  UserProgression copyWith({
    int? level,
    int? currentExp,
    int? totalExp,
    int? streak,
    DateTime? lastStudyDate,
    int? wordsMastered,
    int? totalReviews,
  }) {
    return UserProgression(
      level: level ?? this.level,
      currentExp: currentExp ?? this.currentExp,
      totalExp: totalExp ?? this.totalExp,
      streak: streak ?? this.streak,
      lastStudyDate: lastStudyDate ?? this.lastStudyDate,
      wordsMastered: wordsMastered ?? this.wordsMastered,
      totalReviews: totalReviews ?? this.totalReviews,
    );
  }

  Map<String, dynamic> toJson() => {
        'level': level,
        'currentExp': currentExp,
        'totalExp': totalExp,
        'streak': streak,
        'lastStudyDate': lastStudyDate?.toIso8601String(),
        'wordsMastered': wordsMastered,
        'totalReviews': totalReviews,
      };

  factory UserProgression.fromJson(Map<String, dynamic> json) =>
      UserProgression(
        level: json['level'] as int? ?? 1,
        currentExp: json['currentExp'] as int? ?? 0,
        totalExp: json['totalExp'] as int? ?? 0,
        streak: json['streak'] as int? ?? 1,
        lastStudyDate: json['lastStudyDate'] != null
            ? DateTime.tryParse(json['lastStudyDate'] as String)
            : null,
        wordsMastered: json['wordsMastered'] as int? ?? 0,
        totalReviews: json['totalReviews'] as int? ?? 0,
      );
}
