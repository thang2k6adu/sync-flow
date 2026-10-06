class AppSettings {
  final int dailyWordGoal;
  final bool autoPlayAudio;
  final bool dailyReminderEnabled;
  final String reminderTime;
  final bool hapticFeedback;

  const AppSettings({
    this.dailyWordGoal = 10,
    this.autoPlayAudio = true,
    this.dailyReminderEnabled = true,
    this.reminderTime = '20:00',
    this.hapticFeedback = true,
  });

  AppSettings copyWith({
    int? dailyWordGoal,
    bool? autoPlayAudio,
    bool? dailyReminderEnabled,
    String? reminderTime,
    bool? hapticFeedback,
  }) {
    return AppSettings(
      dailyWordGoal: dailyWordGoal ?? this.dailyWordGoal,
      autoPlayAudio: autoPlayAudio ?? this.autoPlayAudio,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
    );
  }

  Map<String, dynamic> toJson() => {
        'dailyWordGoal': dailyWordGoal,
        'autoPlayAudio': autoPlayAudio,
        'dailyReminderEnabled': dailyReminderEnabled,
        'reminderTime': reminderTime,
        'hapticFeedback': hapticFeedback,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        dailyWordGoal: json['dailyWordGoal'] as int? ?? 10,
        autoPlayAudio: json['autoPlayAudio'] as bool? ?? true,
        dailyReminderEnabled: json['dailyReminderEnabled'] as bool? ?? true,
        reminderTime: json['reminderTime'] as String? ?? '20:00',
        hapticFeedback: json['hapticFeedback'] as bool? ?? true,
      );
}
