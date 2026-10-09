import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/presentation/progression/widgets/level_up_dialog.dart';
import 'package:pp191225/presentation/vocab/controllers/study_session_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/exercise_view.dart';
import 'package:pp191225/presentation/vocab/widgets/flashcard_flip_view.dart';
import 'package:pp191225/presentation/vocab/widgets/leech_rescue_widgets.dart';
import 'package:pp191225/presentation/vocab/widgets/srs_rating_bar.dart';
import 'package:pp191225/presentation/vocab/widgets/typing_challenge_view.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class StudySessionScreen extends ConsumerWidget {
  final String? deckId;

  const StudySessionScreen({super.key, this.deckId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<ProgressionState>(progressionControllerProvider, (prev, next) {
      if (next.didLevelUp) {
        showDialog(
          context: context,
          builder: (_) => LevelUpDialog(
            progression: next.progression,
            onDismiss: () => ref
                .read(progressionControllerProvider.notifier)
                .dismissLevelUp(),
          ),
        );
      }
    });

    final state = ref.watch(studySessionControllerProvider(deckId));
    final controller = ref.read(
      studySessionControllerProvider(deckId).notifier,
    );

    if (state.isLoading) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(color: ChunkyColors.brand),
              SizedBox(height: 16),
              Text(
                'Đang chuẩn bị thẻ ôn tập...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ChunkyColors.textMain,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: ChunkyColors.textMain),
            onPressed: () => context.pop(),
          ),
          title: const Text(
            'Ôn tập từ vựng',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
              color: ChunkyColors.textMain,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.error_outline_rounded,
                  size: 56,
                  color: ChunkyColors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  'Không thể tải hàng đợi:\n${state.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: ChunkyColors.textSub,
                  ),
                ),
                const SizedBox(height: 24),
                ChunkyButton(
                  label: 'Thử lại',
                  onPressed: () => controller.restart(),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.isCompleted) {
      final completedCount = state.completedResults.length;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close_rounded, color: ChunkyColors.textMain),
            onPressed: () => context.pop(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    color: state.isLeechRescueMode
                        ? ChunkyColors.coral
                        : ChunkyColors.yellow,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: state.isLeechRescueMode
                          ? const Color(0xFFC52940)
                          : const Color(0xFFE5A100),
                      width: 4,
                    ),
                  ),
                  child: Icon(
                    state.isLeechRescueMode
                        ? Icons.local_fire_department_rounded
                        : Icons.emoji_events_rounded,
                    size: 52,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  state.isLeechRescueMode
                      ? 'Phiên cứu trợ hoàn thành!'
                      : 'Tuyệt vời! Hoàn thành!',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ChunkyColors.textMain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  completedCount > 0
                      ? state.isLeechRescueMode
                            ? 'Bạn đã ôn tập $completedCount từ khó nhớ. Tiếp tục cố gắng nhé!'
                            : 'Bạn đã hoàn thành xuất sắc $completedCount thẻ ôn tập hôm nay.'
                      : 'Bạn đã ôn tập xong tất cả thẻ từ đến hạn!',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: ChunkyColors.textSub,
                  ),
                ),
                const SizedBox(height: 24),
                ChunkyCard(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            color: ChunkyColors.green,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '$completedCount thẻ',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.textMain,
                            ),
                          ),
                          const Text(
                            'Đã ôn tập',
                            style: TextStyle(
                              fontSize: 12,
                              color: ChunkyColors.textSub,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 2,
                        color: ChunkyColors.border,
                      ),
                      Column(
                        children: [
                          const Icon(
                            Icons.bolt_rounded,
                            color: ChunkyColors.yellow,
                            size: 28,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            '+${completedCount * 10} EXP',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: ChunkyColors.amberText,
                            ),
                          ),
                          const Text(
                            'Kinh nghiệm',
                            style: TextStyle(
                              fontSize: 12,
                              color: ChunkyColors.textSub,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ChunkyButton(label: 'Tiếp tục', onPressed: () => context.pop()),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    }

    final currentItem = state.currentItem;
    if (currentItem == null) {
      return const Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Text(
            'Không có thẻ nào trong hàng đợi',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: ChunkyColors.textSub,
            ),
          ),
        ),
      );
    }

    final total = state.queue.length;
    final current = state.currentIndex + 1;
    final progress = total > 0 ? current / total : 0.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: ChunkyColors.textSub),
          onPressed: () => context.pop(),
        ),
        title: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Column(
            children: [
              ChunkyProgressBar(
                value: progress,
                height: 12,
                color: state.isLeechRescueMode
                    ? ChunkyColors.coral
                    : ChunkyColors.brand,
                trackColor: ChunkyColors.border,
              ),
              // Study Mode indicator
              const SizedBox(height: 4),
              _StudyModeLabel(mode: state.studyMode),
            ],
          ),
        ),
        titleSpacing: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Column(
            children: [
              // Leech badge trên AppBar
              if (currentItem.isLeech)
                Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: LeechBadge(lapsesCount: currentItem.lapsesCount),
                ),
              const Divider(
                height: 2,
                thickness: 2,
                color: ChunkyColors.border,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(child: _buildStudyContent(state, currentItem, controller)),

          // Action Bar
          if (state.studyMode == StudyMode.flashcard)
            SrsRatingBar(onRating: (rating) => controller.submitRating(rating))
          else if (state.isExerciseSubmitted)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: ChunkyColors.border, width: 2)),
              ),
              child: SafeArea(
                top: false,
                child: ChunkyButton(
                  label: 'Tiếp tục',
                  onPressed: () => controller.submitRating(null),
                ),
              ),
            ),
        ],
      ),
    );
  }

  /// Build nội dung học theo Study Mode hiện tại
  Widget _buildStudyContent(
    StudySessionState state,
    StudyItem currentItem,
    StudySessionController controller,
  ) {
    switch (state.studyMode) {
      case StudyMode.flashcard:
        return Center(
          child: FlashcardFlipView(
            item: currentItem,
            isFlipped: state.isFlipped,
            onFlip: controller.flipCard,
          ),
        );

      case StudyMode.sentenceBuilder:
        if (currentItem.currentExercise != null) {
          return ExerciseView(
            exercise: currentItem.currentExercise!,
            selectedTokens: state.selectedTokens,
            isSubmitted: state.isExerciseSubmitted,
            isCorrect: state.isExerciseCorrect,
            onSelectToken: controller.addToken,
            onRemoveToken: controller.removeToken,
            onCheck: controller.checkExercise,
            onHint: controller.useHint,
            usedHint: state.usedHint,
          );
        }
        // Fallback to flashcard if no exercise available
        return Center(
          child: FlashcardFlipView(
            item: currentItem,
            isFlipped: state.isFlipped,
            onFlip: controller.flipCard,
          ),
        );

      case StudyMode.typingChallenge:
        if (currentItem.currentExercise != null) {
          return TypingChallengeView(
            exercise: currentItem.currentExercise!,
            isSubmitted: state.isExerciseSubmitted,
            isCorrect: state.isExerciseCorrect,
            userAnswer: state.typingAnswer,
            usedHint: state.usedHint,
            onHint: controller.useHint,
            onSubmit: controller.checkTypingAnswer,
          );
        }
        // Fallback to flashcard if no exercise available
        return Center(
          child: FlashcardFlipView(
            item: currentItem,
            isFlipped: state.isFlipped,
            onFlip: controller.flipCard,
          ),
        );
    }
  }

  IconData _getModeIcon(StudyMode mode) {
    return switch (mode) {
      StudyMode.flashcard => Icons.style_rounded,
      StudyMode.sentenceBuilder => Icons.sort_rounded,
      StudyMode.typingChallenge => Icons.keyboard_rounded,
    };
  }

  String _getModeTooltip(StudyMode mode) {
    return switch (mode) {
      StudyMode.flashcard => 'Chuyển sang Ghép câu',
      StudyMode.sentenceBuilder => 'Chuyển sang Gõ từ',
      StudyMode.typingChallenge => 'Chuyển sang Flashcard',
    };
  }
}

/// Label nhỏ hiển thị Study Mode hiện tại dưới progress bar
class _StudyModeLabel extends StatelessWidget {
  final StudyMode mode;

  const _StudyModeLabel({required this.mode});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (mode) {
      StudyMode.flashcard => ('Lật thẻ', ChunkyColors.brand),
      StudyMode.sentenceBuilder => ('Ghép câu', ChunkyColors.mint),
      StudyMode.typingChallenge => ('Gõ từ', ChunkyColors.orange),
    };

    return Text(
      label,
      style: TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        color: color,
        letterSpacing: 0.5,
      ),
    );
  }
}
