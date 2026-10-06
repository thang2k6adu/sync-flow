import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/presentation/progression/widgets/level_up_dialog.dart';
import 'package:pp191225/presentation/vocab/controllers/study_session_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/exercise_view.dart';
import 'package:pp191225/presentation/vocab/widgets/flashcard_flip_view.dart';
import 'package:pp191225/presentation/vocab/widgets/srs_rating_bar.dart';
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
            onDismiss: () =>
                ref.read(progressionControllerProvider.notifier).dismissLevelUp(),
          ),
        );
      }
    });

    final state = ref.watch(studySessionControllerProvider(deckId));
    final controller = ref.read(studySessionControllerProvider(deckId).notifier);

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
                const Icon(Icons.error_outline_rounded, size: 56, color: ChunkyColors.red),
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
                    color: ChunkyColors.yellow,
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFFE5A100), width: 4),
                  ),
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 52,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tuyệt vời! Hoàn thành!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ChunkyColors.textMain,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  completedCount > 0
                    ? 'Bạn đã hoàn thành xuất sắc $completedCount thẻ ôn tập hôm nay.'
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
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          const Icon(Icons.check_circle_rounded, color: ChunkyColors.green, size: 28),
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
                            style: TextStyle(fontSize: 12, color: ChunkyColors.textSub, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Container(height: 40, width: 2, color: ChunkyColors.border),
                      Column(
                        children: [
                          const Icon(Icons.bolt_rounded, color: ChunkyColors.yellow, size: 28),
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
                            style: TextStyle(fontSize: 12, color: ChunkyColors.textSub, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                ChunkyButton(
                  label: 'Tiếp tục',
                  onPressed: () => context.pop(),
                ),
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
            style: TextStyle(fontWeight: FontWeight.w600, color: ChunkyColors.textSub),
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
          child: ChunkyProgressBar(
            value: progress,
            height: 12,
            color: ChunkyColors.brand,
            trackColor: ChunkyColors.border,
          ),
        ),
        titleSpacing: 0,
        actions: [
          if (currentItem.currentExercise != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: IconButton(
                icon: Icon(
                  state.isExerciseMode
                      ? Icons.style_rounded
                      : Icons.spellcheck_rounded,
                  color: ChunkyColors.brand,
                ),
                tooltip: state.isExerciseMode
                    ? 'Chuyển sang Flashcard'
                    : 'Chuyển sang Bài tập câu',
                onPressed: () => controller.toggleMode(),
              ),
            ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: ChunkyColors.border),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: state.isExerciseMode && currentItem.currentExercise != null
                ? ExerciseView(
                    exercise: currentItem.currentExercise!,
                    selectedTokens: state.selectedTokens,
                    isSubmitted: state.isExerciseSubmitted,
                    isCorrect: state.isExerciseCorrect,
                    onSelectToken: controller.addToken,
                    onRemoveToken: controller.removeToken,
                    onCheck: controller.checkExercise,
                    onHint: controller.useHint,
                    usedHint: state.usedHint,
                  )
                : Center(
                    child: FlashcardFlipView(
                      item: currentItem,
                      isFlipped: state.isFlipped,
                      onFlip: controller.flipCard,
                    ),
                  ),
          ),

          // SRS Action Rating Bar
          SrsRatingBar(
            onRating: (rating) => controller.submitRating(rating),
          ),
        ],
      ),
    );
  }
}
