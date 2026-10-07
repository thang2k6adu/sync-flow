import 'package:flutter/material.dart';

class AppSettings {
  final int dailyWordGoal;
  final bool autoPlayAudio;
  final bool dailyReminderEnabled;
  final String reminderTime;
  final bool hapticFeedback;
  final ThemeMode themeMode;

  const AppSettings({
    this.dailyWordGoal = 10,
    this.autoPlayAudio = true,
    this.dailyReminderEnabled = true,
    this.reminderTime = '20:00',
    this.hapticFeedback = true,
    this.themeMode = ThemeMode.system,
  });

  AppSettings copyWith({
    int? dailyWordGoal,
    bool? autoPlayAudio,
    bool? dailyReminderEnabled,
    String? reminderTime,
    bool? hapticFeedback,
    ThemeMode? themeMode,
  }) {
    return AppSettings(
      dailyWordGoal: dailyWordGoal ?? this.dailyWordGoal,
      autoPlayAudio: autoPlayAudio ?? this.autoPlayAudio,
      dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
      reminderTime: reminderTime ?? this.reminderTime,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      themeMode: themeMode ?? this.themeMode,
    );
  }

  Map<String, dynamic> toJson() => {
        'dailyWordGoal': dailyWordGoal,
        'autoPlayAudio': autoPlayAudio,
        'dailyReminderEnabled': dailyReminderEnabled,
        'reminderTime': reminderTime,
        'hapticFeedback': hapticFeedback,
        'themeMode': themeMode.name,
      };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
        dailyWordGoal: json['dailyWordGoal'] as int? ?? 10,
        autoPlayAudio: json['autoPlayAudio'] as bool? ?? true,
        dailyReminderEnabled: json['dailyReminderEnabled'] as bool? ?? true,
        reminderTime: json['reminderTime'] as String? ?? '20:00',
        hapticFeedback: json['hapticFeedback'] as bool? ?? true,
        themeMode: _parseThemeMode(json['themeMode'] as String?),
      );

  static ThemeMode _parseThemeMode(String? val) {
    switch (val) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
      default:
        return ThemeMode.system;
    }
  }
}

