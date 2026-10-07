import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/domain/entities/vocab/study_submit_result.dart';
import 'package:pp191225/domain/usecases/vocab/get_study_queue_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/submit_study_usecase.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/providers/usecases_provider.dart';

/// Enum cho 3 chế độ Study Mode
enum StudyMode {
  flashcard, // Level 1: Lật thẻ Active Recall
  sentenceBuilder, // Level 2: Ghép câu Sentence Builder
  typingChallenge, // Level 3: Gõ từ Active Production
}

class StudySessionState {
  final bool isLoading;
  final String? errorMessage;
  final List<StudyItem> queue;
  final int currentIndex;
  final bool isFlipped;
  final StudyMode studyMode;
  final List<String> selectedTokens;
  final bool isExerciseSubmitted;
  final bool isExerciseCorrect;
  final int mistakesCount;
  final bool usedHint;
  final int startTimeMs;
  final bool isCompleted;
  final List<StudySubmitResult> completedResults;
  final String? typingAnswer;
  final bool isLeechRescueMode;
  final bool isCramMode;

  const StudySessionState({
    this.isLoading = true,
    this.errorMessage,
    this.queue = const [],
    this.currentIndex = 0,
    this.isFlipped = false,
    this.studyMode = StudyMode.flashcard,
    this.selectedTokens = const [],
    this.isExerciseSubmitted = false,
    this.isExerciseCorrect = false,
    this.mistakesCount = 0,
    this.usedHint = false,
    this.startTimeMs = 0,
    this.isCompleted = false,
    this.completedResults = const [],
    this.typingAnswer,
    this.isLeechRescueMode = false,
    this.isCramMode = false,
  });

  StudyItem? get currentItem =>
      (queue.isNotEmpty && currentIndex < queue.length)
          ? queue[currentIndex]
          : null;

  /// Backward-compatible getters
  bool get isExerciseMode =>
      studyMode == StudyMode.sentenceBuilder ||
      studyMode == StudyMode.typingChallenge;

  /// Số lượng thẻ Leech trong queue hiện tại
  int get leechCount => queue.where((item) => item.isLeech).length;

  StudySessionState copyWith({
    bool? isLoading,
    String? errorMessage,
    List<StudyItem>? queue,
    int? currentIndex,
    bool? isFlipped,
    StudyMode? studyMode,
    List<String>? selectedTokens,
    bool? isExerciseSubmitted,
    bool? isExerciseCorrect,
    int? mistakesCount,
    bool? usedHint,
    int? startTimeMs,
    bool? isCompleted,
    List<StudySubmitResult>? completedResults,
    String? typingAnswer,
    bool? isLeechRescueMode,
    bool? isCramMode,
  }) {
    return StudySessionState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      queue: queue ?? this.queue,
      currentIndex: currentIndex ?? this.currentIndex,
      isFlipped: isFlipped ?? this.isFlipped,
      studyMode: studyMode ?? this.studyMode,
      selectedTokens: selectedTokens ?? this.selectedTokens,
      isExerciseSubmitted: isExerciseSubmitted ?? this.isExerciseSubmitted,
      isExerciseCorrect: isExerciseCorrect ?? this.isExerciseCorrect,
      mistakesCount: mistakesCount ?? this.mistakesCount,
      usedHint: usedHint ?? this.usedHint,
      startTimeMs: startTimeMs ?? this.startTimeMs,
      isCompleted: isCompleted ?? this.isCompleted,
      completedResults: completedResults ?? this.completedResults,
      typingAnswer: typingAnswer ?? this.typingAnswer,
      isLeechRescueMode: isLeechRescueMode ?? this.isLeechRescueMode,
      isCramMode: isCramMode ?? this.isCramMode,
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
    Future.microtask(() => _loadQueue(arg));
    return const StudySessionState(isLoading: true);
  }

  Future<void> _loadQueue(String? deckId) async {
    state = state.copyWith(isLoading: true, errorMessage: null, isCramMode: deckId != null);
    try {
      // Tăng limit để có thể lấy toàn bộ (hoặc tối đa 100) thẻ từ cần ôn trong 1 bộ
      final result = await _getStudyQueue(
        deckId: deckId,
        limit: deckId != null ? 100 : 20,
      );

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
        (queue) {
          final firstItem = queue.isNotEmpty ? queue.first : null;
          final mode = _determineModeForItem(firstItem);

          state = state.copyWith(
            isLoading: false,
            queue: queue,
            currentIndex: 0,
            isFlipped: false,
            studyMode: mode,
            startTimeMs: DateTime.now().millisecondsSinceEpoch,
            isCompleted: queue.isEmpty,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Load chỉ các thẻ Leech cho phiên Leech Rescue
  Future<void> startLeechRescue() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final result = await _getStudyQueue(limit: 50);

      result.fold(
        (failure) => state = state.copyWith(
          isLoading: false,
          errorMessage: failure.message,
        ),
        (allQueue) {
          final leechCards =
              allQueue.where((item) => item.isLeech).toList();

          if (leechCards.isEmpty) {
            state = state.copyWith(
              isLoading: false,
              isCompleted: true,
              isLeechRescueMode: true,
            );
            return;
          }

          // Leech rescue luôn bắt đầu ở Level 1 (Flashcard) để giảm tải nhận thức
          state = state.copyWith(
            isLoading: false,
            queue: leechCards,
            currentIndex: 0,
            isFlipped: false,
            studyMode: StudyMode.flashcard,
            startTimeMs: DateTime.now().millisecondsSinceEpoch,
            isCompleted: false,
            isLeechRescueMode: true,
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Xác định Study Mode phù hợp: Level 1 -> Flashcard, Level 2 -> Sentence Builder, Level 3+ -> Roll theo Backend
  StudyMode _determineModeForItem(StudyItem? item) {
    if (item == null || item.currentExercise == null) {
      return StudyMode.flashcard;
    }

    if (item.masteryLevel <= 1) {
      return StudyMode.flashcard;
    } else if (item.masteryLevel == 2) {
      return StudyMode.sentenceBuilder;
    } else {
      // masteryLevel >= 3: Backend được phép roll giữa các loại bài tập
      final exerciseType = item.currentExercise!.exerciseType;
      if (exerciseType == 'sentence_builder') {
        return StudyMode.sentenceBuilder;
      } else if (exerciseType == 'typing' || exerciseType == 'typing_challenge') {
        return StudyMode.typingChallenge;
      }
      return StudyMode.typingChallenge; // Fallback an toàn cho Level 3+
    }
  }

  void flipCard() {
    state = state.copyWith(isFlipped: !state.isFlipped);
  }

  /// Cycle qua 3 modes: flashcard → sentenceBuilder → typingChallenge → flashcard
  void toggleMode() {
    final item = state.currentItem;
    if (item == null || item.currentExercise == null) return;

    final nextMode = switch (state.studyMode) {
      StudyMode.flashcard => StudyMode.sentenceBuilder,
      StudyMode.sentenceBuilder => StudyMode.typingChallenge,
      StudyMode.typingChallenge => StudyMode.flashcard,
    };

    state = state.copyWith(
      studyMode: nextMode,
      selectedTokens: [],
      isExerciseSubmitted: false,
      isExerciseCorrect: false,
      typingAnswer: null,
    );
  }

  void useHint() {
    state = state.copyWith(usedHint: true);
  }

  void addToken(String token) {
    if (state.isExerciseSubmitted) return;
    final exercise = state.currentItem?.currentExercise;
    final isFillInBlank = exercise != null &&
        (exercise.exerciseType == 'typing' ||
            exercise.exerciseType == 'fill_in_blank' ||
            exercise.tokens.length == 1 ||
            exercise.targetSentence.contains('___'));

    if (isFillInBlank) {
      // Dạng điền từ: chỉ chọn 1 từ vào chỗ trống, chọn từ khác sẽ thay thế
      state = state.copyWith(selectedTokens: [token]);
    } else {
      final updated = List<String>.from(state.selectedTokens)..add(token);
      state = state.copyWith(selectedTokens: updated);
    }
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
    final isFillInBlank = exercise.exerciseType == 'typing' ||
        exercise.exerciseType == 'fill_in_blank' ||
        exercise.targetSentence.contains('___') ||
        exercise.tokens.length == 1;

    bool isCorrect = false;
    if (isFillInBlank) {
      if (state.selectedTokens.isNotEmpty) {
        final userWord = state.selectedTokens.first.trim().toLowerCase();
        isCorrect = exercise.tokens.any((t) => t.trim().toLowerCase() == userWord);
      }
    } else {
      final userSentence = state.selectedTokens.join(' ').trim().toLowerCase();
      final targetSentence = exercise.targetSentence.trim().toLowerCase();
      final targetTokens = exercise.tokens.join(' ').trim().toLowerCase();
      isCorrect = userSentence == targetSentence ||
          userSentence == targetTokens ||
          _normalize(userSentence) == _normalize(targetSentence);
    }

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

  /// Submit cho Typing Challenge (Level 3)
  void checkTypingAnswer(String answer) {
    final item = state.currentItem;
    if (item == null || item.currentExercise == null) return;

    final exercise = item.currentExercise!;
    final correctWord = exercise.tokens.isNotEmpty
        ? exercise.tokens[exercise.targetIndex]
        : '';

    final userWord = answer.trim().toLowerCase();
    final isCorrect = userWord == correctWord.trim().toLowerCase();

    final newMistakes = isCorrect ? state.mistakesCount : state.mistakesCount + 1;

    if (isCorrect) {
      ref.read(progressionControllerProvider.notifier).recordCorrectExercise();
    }

    state = state.copyWith(
      isExerciseSubmitted: true,
      isExerciseCorrect: isCorrect,
      mistakesCount: newMistakes,
      typingAnswer: answer,
      isFlipped: true,
    );
  }

  String _normalize(String text) {
    return text
        .replaceAll(RegExp(r'[^\w\s]'), '')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
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
      isCram: state.isCramMode,
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
      final mode = _determineModeForItem(nextItem);

      state = state.copyWith(
        currentIndex: nextIndex,
        isFlipped: false,
        studyMode: mode,
        selectedTokens: [],
        isExerciseSubmitted: false,
        isExerciseCorrect: false,
        mistakesCount: 0,
        usedHint: false,
        startTimeMs: DateTime.now().millisecondsSinceEpoch,
        completedResults: newResults,
        typingAnswer: null,
      );
    }
  }

  void restart() {
    _loadQueue(arg);
  }
}
