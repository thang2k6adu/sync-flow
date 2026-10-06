import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/presentation/progression/widgets/level_up_dialog.dart';
import 'package:pp191225/presentation/vocab/controllers/study_session_controller.dart';
import 'package:pp191225/presentation/vocab/widgets/exercise_view.dart';
import 'package:pp191225/presentation/vocab/widgets/flashcard_flip_view.dart';
import 'package:pp191225/presentation/vocab/widgets/srs_rating_bar.dart';

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
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 16),
              Text('Đang tải hàng đợi ôn tập SRS...'),
            ],
          ),
        ),
      );
    }

    if (state.errorMessage != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Ôn tập từ vựng')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error_outline, size: 56, color: AppColors.error),
                const SizedBox(height: 16),
                Text(
                  'Không thể tải hàng đợi: ${state.errorMessage}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => controller.restart(),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (state.isCompleted) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Hoàn thành'),
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => context.pop(),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppColors.secondary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.emoji_events,
                    size: 56,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Chúc mừng cậu! 🎉',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.neutral900,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  state.completedResults.isNotEmpty
                      ? 'Cậu đã hoàn thành xuất sắc ${state.completedResults.length} thẻ từ hôm nay.'
                      : 'Hàng đợi ôn tập trống! Bạn đã học hết tất cả các thẻ đến hạn.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: AppColors.neutral700,
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Icons.check),
                  label: const Text('Quay lại kho từ'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(200, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final currentItem = state.currentItem;
    if (currentItem == null) {
      return const Scaffold(
        body: Center(child: Text('Không có thẻ nào')),
      );
    }

    final total = state.queue.length;
    final current = state.currentIndex + 1;
    final progress = total > 0 ? current / total : 0.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Ôn tập ($current/$total)'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        actions: [
          if (currentItem.currentExercise != null)
            IconButton(
              icon: Icon(
                state.isExerciseMode
                    ? Icons.style_outlined
                    : Icons.edit_note_outlined,
              ),
              tooltip: state.isExerciseMode
                  ? 'Chuyển sang Flashcard'
                  : 'Chuyển sang Bài tập câu',
              onPressed: () => controller.toggleMode(),
            ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: AppColors.neutral200,
            valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
          ),
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
