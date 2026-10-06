import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/domain/entities/vocab/card_exercise.dart';

class ExerciseView extends StatelessWidget {
  final CardExercise exercise;
  final List<String> selectedTokens;
  final bool isSubmitted;
  final bool isCorrect;
  final Function(String) onSelectToken;
  final Function(int) onRemoveToken;
  final VoidCallback onCheck;
  final VoidCallback onHint;
  final bool usedHint;

  const ExerciseView({
    super.key,
    required this.exercise,
    required this.selectedTokens,
    required this.isSubmitted,
    required this.isCorrect,
    required this.onSelectToken,
    required this.onRemoveToken,
    required this.onCheck,
    required this.onHint,
    required this.usedHint,
  });

  @override
  Widget build(BuildContext context) {
    // Pool of available tokens = tokens + distractorTokens
    final allAvailableTokens = [
      ...exercise.tokens,
      ...exercise.distractorTokens,
    ];

    // Count how many times each token is available vs currently selected
    final Map<String, int> availableCounts = {};
    for (var token in allAvailableTokens) {
      availableCounts[token] = (availableCounts[token] ?? 0) + 1;
    }
    for (var token in selectedTokens) {
      if (availableCounts.containsKey(token)) {
        availableCounts[token] = availableCounts[token]! - 1;
      }
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Prompt & Meaning Hint
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.primary.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Sắp xếp câu hoàn chỉnh:',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                    if (exercise.meaningHint != null)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.lightbulb_outline,
                          color: usedHint ? Colors.amber[700] : AppColors.neutral500,
                          size: 20,
                        ),
                        tooltip: 'Gợi ý',
                        onPressed: onHint,
                      ),
                  ],
                ),
                if (exercise.vietnameseTranslation != null) ...[
                  const SizedBox(height: 6),
                  Text(
                    exercise.vietnameseTranslation!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.neutral900,
                    ),
                  ),
                ],
                if (usedHint && exercise.meaningHint != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Gợi ý: ${exercise.meaningHint}',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: Colors.amber[900],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Answer Zone (Selected tokens)
          Container(
            constraints: const Duration(milliseconds: 300) == Duration.zero
                ? null
                : const BoxConstraints(minHeight: 110),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSubmitted
                    ? (isCorrect ? AppColors.success : AppColors.error)
                    : AppColors.neutral200,
                width: 2,
              ),
            ),
            child: selectedTokens.isEmpty
                ? const Center(
                    child: Text(
                      'Chạm vào các từ bên dưới để ghép câu',
                      style: TextStyle(fontSize: 13, color: AppColors.neutral500),
                    ),
                  )
                : Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(selectedTokens.length, (index) {
                      final token = selectedTokens[index];
                      return ActionChip(
                        label: Text(
                          token,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                        backgroundColor: AppColors.secondary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(color: AppColors.primary, width: 1),
                        ),
                        onPressed: isSubmitted ? null : () => onRemoveToken(index),
                      );
                    }),
                  ),
          ),
          const SizedBox(height: 16),

          // Feedback banner if submitted
          if (isSubmitted) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isCorrect
                    ? AppColors.success.withOpacity(0.15)
                    : AppColors.error.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    isCorrect ? Icons.check_circle : Icons.cancel,
                    color: isCorrect ? Colors.green[700] : AppColors.error,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect ? 'Tuyệt vời! Đáp án chính xác.' : 'Chưa đúng rồi!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isCorrect ? Colors.green[800] : AppColors.error,
                          ),
                        ),
                        if (!isCorrect)
                          Text(
                            'Đáp án đúng: "${exercise.targetSentence}"',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Token options pool
          const Text(
            'Kho từ gợi ý:',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.neutral700,
            ),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: allAvailableTokens.toSet().map((token) {
              final remainingCount = availableCounts[token] ?? 0;
              final isAvailable = remainingCount > 0 && !isSubmitted;

              return ActionChip(
                label: Text(token),
                labelStyle: TextStyle(
                  color: isAvailable ? AppColors.neutral900 : AppColors.slate[4],
                  fontWeight: FontWeight.w500,
                ),
                backgroundColor: isAvailable ? AppColors.slate[1] : AppColors.slate[2],
                side: BorderSide(
                  color: isAvailable ? AppColors.neutral200 : Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                onPressed: isAvailable ? () => onSelectToken(token) : null,
              );
            }).toList(),
          ),
          const SizedBox(height: 20),

          // Check button
          if (!isSubmitted)
            ElevatedButton(
              onPressed: selectedTokens.isNotEmpty ? onCheck : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Kiểm tra đáp án',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
        ],
      ),
    );
  }
}
