import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/card_exercise.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class ExerciseView extends ConsumerWidget {
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

  bool get isFillInBlank =>
      exercise.exerciseType == 'typing' ||
      exercise.exerciseType == 'fill_in_blank' ||
      exercise.tokens.length == 1 ||
      exercise.targetSentence.contains('___');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;

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
            fillColor: colors.surfaceMuted,
            borderColor: colors.border,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isFillInBlank
                              ? Icons.edit_note_rounded
                              : Icons.sort_rounded,
                          size: 18,
                          color: colors.brand,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isFillInBlank
                              ? 'ĐIỀN TỪ VÀO CHỖ TRỐNG'
                              : 'SẮP XẾP CÂU HOÀN CHỈNH',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colors.brand,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    if (exercise.meaningHint != null)
                      ChunkyIconButton.circle(
                        icon: Icons.lightbulb_rounded,
                        variant: usedHint ? FlowButtonVariant.amber : FlowButtonVariant.secondary,
                        size: ChunkyButtonSize.small,
                        tooltip: 'Gợi ý',
                        onPressed: onHint,
                      ),
                  ],
                ),
                const SizedBox(height: 10),

                // Nội dung câu hỏi theo từng loại bài tập
                if (isFillInBlank) ...[
                  // Câu tiếng Anh có chỗ trống
                  _FillInBlankSentence(
                    targetSentence: exercise.targetSentence,
                    selectedToken: selectedTokens.isNotEmpty
                        ? selectedTokens.first
                        : null,
                    isSubmitted: isSubmitted,
                    isCorrect: isCorrect,
                    onRemove: isSubmitted ? null : () => onRemoveToken(0),
                    colors: colors,
                  ),
                  if (exercise.vietnameseTranslation != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      exercise.vietnameseTranslation!,
                      style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                        color: colors.textSub,
                        height: 1.4,
                      ),
                    ),
                  ],
                ] else ...[
                  // Sắp xếp câu: hiển thị nghĩa tiếng Việt làm đề bài
                  if (exercise.vietnameseTranslation != null)
                    Text(
                      exercise.vietnameseTranslation!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                        height: 1.35,
                      ),
                    ),
                ],

                if (usedHint && exercise.meaningHint != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: colors.brandBorder, width: 1.5),
                    ),
                    child: Text(
                      'Gợi ý: ${exercise.meaningHint}',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.brand,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Đối với dạng Sắp xếp câu: cần khung Answer Zone để thả các từ ghép câu
          if (!isFillInBlank) ...[
            ChunkyCard(
              depth: 0,
              fillColor: colors.surface,
              borderColor: isSubmitted
                  ? (isCorrect ? colors.mint : colors.coral)
                  : colors.border,
              padding: const EdgeInsets.all(16),
              child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 90),
                child: selectedTokens.isEmpty
                    ? Center(
                        child: Text(
                          'Chạm vào các từ bên dưới để ghép câu',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colors.textSub,
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
          ],

          // Feedback banner if submitted
          if (isSubmitted) ...[
            ChunkyCard(
              fillColor: isCorrect
                  ? (context.isDarkMode ? const Color(0xFF0F392B) : const Color(0xFFE8FAF4))
                  : (context.isDarkMode ? const Color(0xFF3E1C27) : const Color(0xFFFFF1F4)),
              borderColor: isCorrect ? colors.mint : colors.coral,
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      color: isCorrect ? colors.mint : colors.coral,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isCorrect ? Icons.check_rounded : Icons.close_rounded,
                      color: Colors.white,
                      size: 22,
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
                            color: isCorrect ? colors.mint : colors.coral,
                          ),
                        ),
                        if (!isCorrect) ...[
                          const SizedBox(height: 3),
                          Text(
                            isFillInBlank
                                ? 'Đáp án: "${exercise.tokens.isNotEmpty ? exercise.tokens.first : exercise.targetSentence}"'
                                : 'Đáp án: "${exercise.targetSentence}"',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: colors.coral,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  ChunkyIconButton.circle(
                    icon: Icons.volume_up_rounded,
                    variant: isCorrect ? FlowButtonVariant.mint : FlowButtonVariant.coral,
                    size: ChunkyButtonSize.small,
                    tooltip: 'Nghe phát âm',
                    onPressed: () {
                      final sentenceToSpeak = isFillInBlank
                          ? exercise.targetSentence.replaceAll(
                              RegExp(r'_{2,}'),
                              exercise.tokens.isNotEmpty ? exercise.tokens.first : '',
                            )
                          : exercise.targetSentence;
                      ref.read(ttsServiceProvider).speak(text: sentenceToSpeak);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],

          // Token pool (Từ gợi ý)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              isFillInBlank
                  ? 'Chọn từ thích hợp bên dưới để điền vào câu:'
                  : 'Từ gợi ý:',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: colors.textSub,
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
              size: ChunkyButtonSize.large,
              onPressed: selectedTokens.isNotEmpty ? onCheck : null,
            ),
        ],
      ),
    );
  }
}

class _FillInBlankSentence extends StatelessWidget {
  final String targetSentence;
  final String? selectedToken;
  final bool isSubmitted;
  final bool isCorrect;
  final VoidCallback? onRemove;
  final AppThemeColors colors;

  const _FillInBlankSentence({
    required this.targetSentence,
    required this.selectedToken,
    required this.isSubmitted,
    required this.isCorrect,
    required this.onRemove,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final blankRegex = RegExp(r'_{2,}');
    final hasBlank = blankRegex.hasMatch(targetSentence);

    if (!hasBlank) {
      // Trường hợp câu không chứa dấu gạch dưới: hiển thị cả câu và ô trả lời
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            targetSentence,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: colors.textMain,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 12),
          _SlotChip(
            text: selectedToken,
            isSubmitted: isSubmitted,
            isCorrect: isCorrect,
            onTap: onRemove,
            colors: colors,
          ),
        ],
      );
    }

    final parts = targetSentence.split(blankRegex);
    final prefix = parts.isNotEmpty ? parts.first : '';
    final suffix = parts.length > 1 ? parts.sublist(1).join(' ') : '';

    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: colors.textMain,
          height: 1.6,
        ),
        children: [
          TextSpan(text: prefix),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _SlotChip(
                text: selectedToken,
                isSubmitted: isSubmitted,
                isCorrect: isCorrect,
                onTap: onRemove,
                colors: colors,
              ),
            ),
          ),
          TextSpan(text: suffix),
        ],
      ),
    );
  }
}

class _SlotChip extends StatelessWidget {
  final String? text;
  final bool isSubmitted;
  final bool isCorrect;
  final VoidCallback? onTap;
  final AppThemeColors colors;

  const _SlotChip({
    required this.text,
    required this.isSubmitted,
    required this.isCorrect,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: colors.brand,
            width: 2,
            style: BorderStyle.solid,
          ),
        ),
        child: Text(
          ' ______ ',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: colors.brand,
          ),
        ),
      );
    }

    Color bgColor = colors.brandSoft;
    Color borderColor = colors.brandBorder;
    Color textColor = colors.brand;

    if (isSubmitted) {
      if (isCorrect) {
        bgColor = const Color(0xFFE8FAF4);
        borderColor = colors.mint;
        textColor = const Color(0xFF007A55);
      } else {
        bgColor = const Color(0xFFFFF1F4);
        borderColor = colors.coral;
        textColor = colors.coral;
      }
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text!,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            if (!isSubmitted && onTap != null) ...[
              const SizedBox(width: 4),
              Icon(Icons.close_rounded, size: 14, color: textColor),
            ],
          ],
        ),
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
    final colors = context.themeColors;

    if (!widget.selected && !widget.isAvailable) {
      // Ô rỗng giữ chỗ màu mờ (Placeholder slot)
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: colors.surfaceMuted,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colors.border, width: 2),
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

    final faceColor = widget.selected ? colors.brandSoft : colors.surface;
    final baseColor = widget.selected ? colors.brandBase : colors.border;
    final borderColor = widget.selected ? colors.brandBorder : colors.border;
    final textColor = widget.selected ? colors.brand : colors.textMain;

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
