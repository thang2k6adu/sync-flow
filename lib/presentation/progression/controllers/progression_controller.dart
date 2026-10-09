import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/constants/api_constants.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/domain/repositories/progression_repository.dart';
import 'package:pp191225/providers/repositories_provider.dart';
import 'package:pp191225/providers/usecases_provider.dart';

class ProgressionState {
  final UserProgression progression;
  final bool didLevelUp;
  final int lastEarnedExp;

  const ProgressionState({
    this.progression = const UserProgression(),
    this.didLevelUp = false,
    this.lastEarnedExp = 0,
  });

  ProgressionState copyWith({
    UserProgression? progression,
    bool? didLevelUp,
    int? lastEarnedExp,
  }) {
    return ProgressionState(
      progression: progression ?? this.progression,
      didLevelUp: didLevelUp ?? this.didLevelUp,
      lastEarnedExp: lastEarnedExp ?? this.lastEarnedExp,
    );
  }
}

final progressionControllerProvider =
    NotifierProvider<ProgressionController, ProgressionState>(
  ProgressionController.new,
);

class ProgressionController extends Notifier<ProgressionState> {
  late ProgressionRepository _repository;

  @override
  ProgressionState build() {
    _repository = ref.read(progressionRepositoryProvider);
    _load();
    return const ProgressionState();
  }

  Future<void> _load() async {
    final prog = await _repository.getProgression();
    final updatedProg = _checkStreak(prog);
    state = state.copyWith(progression: updatedProg);
    await _repository.saveProgression(updatedProg);
    // Đồng bộ chiều backend -> local khi có mạng (backend là nguồn chân lý cho BXH).
    if (!ApiConstants.useMockData) {
      try {
        final repo = ref.read(gamificationRepositoryProvider);
        final remote = await repo.getProgression();
        remote.fold(
          (_) {},
          (server) async {
            final merged = server.totalExp >= state.progression.totalExp
                ? server
                : state.progression;
            state = state.copyWith(progression: merged);
            await _repository.saveProgression(merged);
          },
        );
      } catch (_) {
        // Offline: giữ local, lần học sau sẽ sync lên.
      }
    }
  }

  UserProgression _checkStreak(UserProgression p) {
    final now = DateTime.now();
    if (p.lastStudyDate == null) {
      return p.copyWith(lastStudyDate: now, streak: 1);
    }

    final lastDate = p.lastStudyDate!;
    final differenceDays = DateTime(now.year, now.month, now.day)
        .difference(DateTime(lastDate.year, lastDate.month, lastDate.day))
        .inDays;

    if (differenceDays == 0) {
      return p; // Cùng một ngày
    } else if (differenceDays == 1) {
      return p.copyWith(streak: p.streak + 1, lastStudyDate: now);
    } else {
      // Đứt chuỗi streak
      return p.copyWith(streak: 1, lastStudyDate: now);
    }
  }

  Future<bool> addExp(int amount) => _addExpAndSync(amount);

  Future<bool> _addExpAndSync(
    int amount, {
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  }) async {
    final current = state.progression;
    var newExp = current.currentExp + amount;
    var newTotalExp = current.totalExp + amount;
    var currentLevel = current.level;
    var leveledUp = false;

    while (newExp >= currentLevel * 100) {
      newExp -= currentLevel * 100;
      currentLevel += 1;
      leveledUp = true;
    }

    final updatedProgression = current.copyWith(
      level: currentLevel,
      currentExp: newExp,
      totalExp: newTotalExp,
    );

    state = state.copyWith(
      progression: updatedProgression,
      didLevelUp: leveledUp,
      lastEarnedExp: amount,
    );

    await _repository.saveProgression(updatedProgression);
    _syncToBackend(
      expGained: amount,
      cardStudied: cardStudied,
      wordMastered: wordMastered,
      correctExercise: correctExercise,
    );
    return leveledUp;
  }

  void _syncToBackend({
    int? expGained,
    bool? cardStudied,
    bool? wordMastered,
    bool? correctExercise,
  }) {
    if (ApiConstants.useMockData) return;
    Future.microtask(() async {
      try {
        final sync = ref.read(syncProgressionUseCaseProvider);
        final result = await sync(
          expGained: expGained,
          cardStudied: cardStudied,
          wordMastered: wordMastered,
          correctExercise: correctExercise,
        );
        result.fold(
          (_) {},
          (server) async {
            // Backend tính lại level/streak chuẩn: lấy về để BXH khớp mọi máy.
            state = state.copyWith(progression: server);
            await _repository.saveProgression(server);
          },
        );
      } catch (_) {
        // Offline: local vẫn đúng, lần sau sync tiếp.
      }
    });
  }

  Future<bool> recordCardStudied({bool isEasy = false}) async {
    final expReward = isEasy ? 15 : 10;
    final current = state.progression;

    final updatedProgression = current.copyWith(
      totalReviews: current.totalReviews + 1,
      wordsMastered: isEasy ? current.wordsMastered + 1 : current.wordsMastered,
    );

    await _repository.saveProgression(updatedProgression);
    state = state.copyWith(progression: updatedProgression);
    // Gộp 1 lần sync trong _addExpAndSync (kèm cardStudied + expGained).
    // Không sync riêng ở đây để backend khỏi cộng 2 lần totalReviews.
    return _addExpAndSync(expReward, cardStudied: true, wordMastered: isEasy);
  }

  Future<bool> recordCorrectExercise() {
    // Gộp 1 lần sync trong _addExpAndSync (kèm correctExercise + expGained).
    return _addExpAndSync(15, correctExercise: true);
  }

  void dismissLevelUp() {
    state = state.copyWith(didLevelUp: false);
  }
}
