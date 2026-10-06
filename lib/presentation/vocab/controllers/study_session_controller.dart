import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';
import 'package:pp191225/domain/usecases/vocab/get_study_queue_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/submit_study_usecase.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/providers/usecases_provider.dart';

class StudySessionState {
  final bool isLoading;
  final String? errorMessage;
  final List<StudyItem> queue;
  final int currentIndex;
  final bool isFlipped;
  final bool isExerciseMode;
  final List<String> selectedTokens;
  final bool isExerciseSubmitted;
  final bool isExerciseCorrect;
  final int mistakesCount;
  final bool usedHint;
  final int startTimeMs;
  final bool isCompleted;
  final List<StudySubmitResult> completedResults;

  const StudySessionState({
    this.isLoading = true,
    this.errorMessage,
    this.queue = const [],
    this.currentIndex = 0,
    this.isFlipped = false,
    this.isExerciseMode = false,
    this.selectedTokens = const [],
    this.isExerciseSubmitted = false,
    this.isExerciseCorrect = false,
    this.mistakesCount = 0,
    this.usedHint = false,
    this.startTimeMs = 0,
    this.isCompleted = false,
    this.completedResults = const [],
  });

  StudyItem? get currentItem =>
      (queue.isNotEmpty && currentIndex < queue.length)
          ? queue[currentIndex]
          : null;

  StudySessionState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<StudyItem>? queue,
    int? currentIndex,
    bool? isFlipped,
    bool? isExerciseMode,
    List<String>? selectedTokens,
    bool? isExerciseSubmitted,
    bool? isExerciseCorrect,
    int? mistakesCount,
    bool? usedHint,
    int? startTimeMs,
    bool? isCompleted,
    List<StudySubmitResult>? completedResults,
  }) {
    return StudySessionState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      isExerciseMode: isExerciseMode ?? this.isExerciseMode,
      selectedTokens: selectedTokens ?? this.selectedTokens,
      isExerciseSubmitted: isExerciseSubmitted ?? this.isExerciseSubmitted,
      isExerciseCorrect: isExerciseCorrect ?? this.isExerciseCorrect,
      mistakesCount: mistakesCount ?? this.mistakesCount,
      usedHint: usedHint ?? this.usedHint,
      startTimeMs: startTimeMs ?? this.startTimeMs,
      isCompleted: isCompleted ?? this.isCompleted,
      completedResults: completedResults ?? this.completedResults,
    );
  }
}

final studySessionControllerProvider = AutoDisposeNotifierProviderFamily<
    StudySessionController, StudySessionState, String?>(
  StudySessionController.new,
);

class StudySessionController
    extends AutoDisposeFamilyNotifier<StudySessionState, String?> {
  late GetStudyQueueUseCase _getStudyQueue;
  late SubmitStudyUseCase _submitStudy;

  @override
  StudySessionState build(String? arg) {
    _getStudyQueue = ref.read(getStudyQueueUseCaseProvider);
    _submitStudy = ref.read(submitStudyUseCaseProvider);
    _loadQueue(arg);
    return const StudySessionState(isLoading: true);
  }

  Future<void> _loadQueue(String? deckId) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final result = await _getStudyQueue(deckId: deckId, limit: 20);

    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.message,
      ),
      (queue) {
        state = state.copyWith(
          isLoading: false,
          queue: queue,
          currentIndex: 0,
          isFlipped: false,
          isExerciseMode: queue.isNotEmpty && queue.first.currentExercise != null,
          startTimeMs: DateTime.now().millisecondsSinceEpoch,
          isCompleted: queue.isEmpty,
        );
      },
    );
  }

  void flipCard() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  void toggleMode() {
    state = state.copyWith(isExerciseMode: !state.isExerciseMode);
  }

  void useHint() {
    state = state.copyWith(usedHint: true);
  }

  void addToken(String token) {
    if (state.isExerciseSubmitted) return;
    final updated = List<String>.from(state.selectedTokens)..add(token);
    state = state.copyWith(selectedTokens: updated);
  }

  void removeToken(int index) {
    if (state.isExerciseSubmitted) return;
    if (index >= 0 && index < state.selectedTokens.length) {
      final updated = List<String>.from(state.selectedTokens)..removeAt(index);
      state = state.copyWith(selectedTokens: updated);
    }
  }

  void checkExercise() {
    final item = state.currentItem;
    if (item == null || item.currentExercise == null) return;

    final exercise = item.currentExercise!;
    final userSentence = state.selectedTokens.join(' ').trim().toLowerCase();
    final targetSentence = exercise.targetSentence.trim().toLowerCase();

    final isCorrect = userSentence == targetSentence;
    final newMistakes = isCorrect ? state.mistakesCount : state.mistakesCount + 1;

    if (isCorrect) {
      ref.read(progressionControllerProvider.notifier).recordCorrectExercise();
    }

    state = state.copyWith(
      isExerciseSubmitted: true,
      isExerciseCorrect: isCorrect,
      mistakesCount: newMistakes,
      isFlipped: true,
    );
  }

  Future<void> submitRating(String rating) async {
    final item = state.currentItem;
    if (item == null) return;

    // Award EXP and update progression
    ref.read(progressionControllerProvider.notifier).recordCardStudied(
      isEasy: rating == 'EASY',
    );

    final now = DateTime.now().millisecondsSinceEpoch;
    final timeSpent = now - state.startTimeMs;

    final submitRes = await _submitStudy(
      cardId: item.cardId,
      masteryLevel: item.masteryLevel,
      timeSpentMs: timeSpent > 0 ? timeSpent : 1000,
      mistakesCount: state.mistakesCount,
      usedHint: state.usedHint,
      manualRating: rating,
    );

    submitRes.fold(
      (failure) {
        // Proceed next even on failure or log
        _moveToNext(null);
      },
      (res) {
        _moveToNext(res);
      },
    );
  }

  void _moveToNext(StudySubmitResult? result) {
    final nextIndex = state.currentIndex + 1;
    final newResults = result != null
        ? [...state.completedResults, result]
        : state.completedResults;

    if (nextIndex >= state.queue.length) {
      state = state.copyWith(
        isCompleted: true,
        completedResults: newResults,
      );
    } else {
      final nextItem = state.queue[nextIndex];
      state = state.copyWith(
        currentIndex: nextIndex,
        isFlipped: false,
        isExerciseMode: nextItem.currentExercise != null,
        selectedTokens: [],
        isExerciseSubmitted: false,
        isExerciseCorrect: false,
        mistakesCount: 0,
        usedHint: false,
        startTimeMs: DateTime.now().millisecondsSinceEpoch,
        completedResults: newResults,
      );
    }
  }

  void restart() {
    _loadQueue(arg);
  }
}
