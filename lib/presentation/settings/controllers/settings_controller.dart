import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/entities/settings/app_settings.dart';
import 'package:pp191225/domain/repositories/settings_repository.dart';
import 'package:pp191225/providers/repositories_provider.dart';

final settingsControllerProvider =
    NotifierProvider<SettingsController, AppSettings>(
  SettingsController.new,
);

class SettingsController extends Notifier<AppSettings> {
  late SettingsRepository _repository;

  @override
  AppSettings build() {
    _repository = ref.read(settingsRepositoryProvider);
    _load();
    return const AppSettings();
  }

  Future<void> _load() async {
    final settings = await _repository.getSettings();
    state = settings;
  }

  Future<void> updateDailyGoal(int goal) async {
    final updated = state.copyWith(dailyWordGoal: goal);
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> toggleAutoPlayAudio() async {
    final updated = state.copyWith(autoPlayAudio: !state.autoPlayAudio);
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> toggleDailyReminder() async {
    final updated = state.copyWith(
      dailyReminderEnabled: !state.dailyReminderEnabled,
    );
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> updateReminderTime(String time) async {
    final updated = state.copyWith(reminderTime: time);
    state = updated;
    await _repository.saveSettings(updated);
  }

  Future<void> toggleHapticFeedback() async {
    final updated = state.copyWith(hapticFeedback: !state.hapticFeedback);
    state = updated;
    await _repository.saveSettings(updated);
  }
}
