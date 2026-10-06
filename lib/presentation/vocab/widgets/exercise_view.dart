import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp191225/domain/entities/vocab/card_exercise.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

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
    final allAvailableTokens = [
      ...exercise.tokens,
      ...exercise.distractorTokens,
    ];

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
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Prompt card
          ChunkyCard(
            fillColor: ChunkyColors.surfaceMuted,
            borderColor: ChunkyColors.border,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'SẮP XẾP CÂU HOÀN CHỈNH',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: ChunkyColors.brand,
                        letterSpacing: 0.8,
                      ),
                    ),
                    if (exercise.meaningHint != null)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.lightbulb_rounded,
                          color: usedHint ? ChunkyColors.yellow : ChunkyColors.textSub,
                          size: 22,
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
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: ChunkyColors.textMain,
                    ),
                  ),
                ],
                if (usedHint && exercise.meaningHint != null) ...[
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7D6),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ChunkyColors.yellow, width: 1.5),
                    ),
                    child: Text(
                      'Gợi ý: ${exercise.meaningHint}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFB27B00),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Answer Zone
          ChunkyCard(
            depth: 0,
            fillColor: Colors.white,
            borderColor: isSubmitted
                ? (isCorrect ? ChunkyColors.green : ChunkyColors.red)
                : ChunkyColors.border,
            padding: const EdgeInsets.all(16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 90),
              child: selectedTokens.isEmpty
                  ? const Center(
                      child: Text(
                        'Chạm vào các từ bên dưới để ghép câu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: ChunkyColors.textSub,
                        ),
                      ),
                    )
                  : Wrap(
                      spacing: 8,
                      runSpacing: 10,
                      children: List.generate(selectedTokens.length, (index) {
                        final token = selectedTokens[index];
                        return _TokenChip(
                          text: token,
                          selected: true,
                          onTap: isSubmitted ? null : () => onRemoveToken(index),
                        );
                      }),
                    ),
            ),
          ),
          const SizedBox(height: 16),

          // Feedback banner if submitted
          if (isSubmitted) ...[
            ChunkyCard(
              fillColor: isCorrect ? const Color(0xFFE8FAF4) : const Color(0xFFFFF1F4),
              borderColor: isCorrect ? const Color(0xFFA6EBD5) : const Color(0xFFFFCCD5),
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isCorrect ? ChunkyColors.mint : ChunkyColors.coral,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check_rounded : Icons.close_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isCorrect ? 'Tuyệt vời! Chính xác!' : 'Chưa đúng rồi!',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: isCorrect ? const Color(0xFF007A55) : const Color(0xFFBE123C),
                          ),
                        ),
                        if (!isCorrect) ...[
                          const SizedBox(height: 2),
                          Text(
                            'Đáp án: "${exercise.targetSentence}"',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFFBE123C),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Token pool
          const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Từ gợi ý:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: ChunkyColors.textSub,
              ),
            ),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 10,
            children: allAvailableTokens.toSet().map((token) {
              final remainingCount = availableCounts[token] ?? 0;
              final isAvailable = remainingCount > 0 && !isSubmitted;

              return _TokenChip(
                text: token,
                selected: false,
                isAvailable: isAvailable,
                onTap: isAvailable ? () => onSelectToken(token) : null,
              );
            }).toList(),
          ),
          const SizedBox(height: 24),

          // Check button
          if (!isSubmitted)
            ChunkyButton.mint(
              label: 'Kiểm tra đáp án',
              onPressed: selectedTokens.isNotEmpty ? onCheck : null,
            ),
        ],
      ),
    );
  }
}

class _TokenChip extends StatefulWidget {
  final String text;
  final bool selected;
  final bool isAvailable;
  final VoidCallback? onTap;

  const _TokenChip({
    required this.text,
    required this.selected,
    this.isAvailable = true,
    this.onTap,
  });

  @override
  State<_TokenChip> createState() => _TokenChipState();
}

class _TokenChipState extends State<_TokenChip> {
  bool _isPressed = false;
  static const double _depth = 3.0;

  @override
  Widget build(BuildContext context) {
    if (!widget.selected && !widget.isAvailable) {
      // Ô rỗng giữ chỗ màu xám (Iconic Duolingo placeholder slot)
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F0F0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE0E0E0), width: 2),
        ),
        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.transparent, // Giấu chữ để giữ đúng kích thước ô
          ),
        ),
      );
    }

    final faceColor = widget.selected ? ChunkyColors.brandSoft : Colors.white;
    final baseColor = widget.selected ? ChunkyColors.brandBorder : const Color(0xFFE5E5E5);
    final borderColor = widget.selected ? ChunkyColors.brandBorder : const Color(0xFFE5E5E5);
    final textColor = widget.selected ? ChunkyColors.brand : ChunkyColors.textMain;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTapDown: (_) {
        HapticFeedback.selectionClick();
        setState(() => _isPressed = true);
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: SizedBox(
        height: 38 + _depth,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 38,
              child: Container(
                decoration: BoxDecoration(
                  color: baseColor,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              curve: Curves.easeOutQuad,
              top: _isPressed ? _depth : 0,
              left: 0,
              right: 0,
              height: 38,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                decoration: BoxDecoration(
                  color: faceColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: borderColor, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: textColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
