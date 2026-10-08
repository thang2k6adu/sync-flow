import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/card_exercise.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Chế độ Level 3: Active Production / Typing Challenge
/// Người dùng gõ chính xác từ vựng từ bàn phím dựa trên gợi ý nghĩa tiếng Việt
/// hoặc câu ví dụ bị khuyết từ.
class TypingChallengeView extends ConsumerStatefulWidget {
  final CardExercise exercise;
  final bool isSubmitted;
  final bool isCorrect;
  final String? userAnswer;
  final bool usedHint;
  final VoidCallback onHint;
  final Function(String answer) onSubmit;

  const TypingChallengeView({
    super.key,
    required this.exercise,
    required this.isSubmitted,
    required this.isCorrect,
    this.userAnswer,
    required this.usedHint,
    required this.onHint,
    required this.onSubmit,
  });

  @override
  ConsumerState<TypingChallengeView> createState() =>
      _TypingChallengeViewState();
}

class _TypingChallengeViewState extends ConsumerState<TypingChallengeView> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;
  bool _hasTyped = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.userAnswer ?? '');
    _focusNode = FocusNode();
    _hasTyped = widget.userAnswer?.isNotEmpty ?? false;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!widget.isSubmitted) {
        _focusNode.requestFocus();
      }
    });
  }

  @override
  void didUpdateWidget(TypingChallengeView oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset khi chuyển sang thẻ mới
    if (oldWidget.exercise.id != widget.exercise.id) {
      _controller.clear();
      _hasTyped = false;
      if (!widget.isSubmitted) {
        _focusNode.requestFocus();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String get _correctAnswer {
    if (widget.exercise.tokens.isNotEmpty) {
      return widget.exercise.tokens[widget.exercise.targetIndex];
    }
    return '';
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    HapticFeedback.mediumImpact();
    widget.onSubmit(text);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final hasExplicitBlank = widget.exercise.targetSentence.contains(RegExp(r'_{2,}'));
    final canGenerateBlank = widget.exercise.tokens.isNotEmpty &&
        widget.exercise.targetIndex >= 0 &&
        widget.exercise.targetIndex < widget.exercise.tokens.length;
    final hasBlank = hasExplicitBlank || canGenerateBlank;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header badge
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
                          Icons.keyboard_rounded,
                          size: 18,
                          color: colors.brand,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'GÕ TỪ VỰNG',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colors.brand,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                    if (widget.exercise.meaningHint != null)
                      IconButton(
                        visualDensity: VisualDensity.compact,
                        icon: Icon(
                          Icons.lightbulb_rounded,
                          color:
                              widget.usedHint ? colors.amber : colors.textSub,
                          size: 22,
                        ),
                        tooltip: 'Gợi ý',
                        onPressed: widget.onHint,
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Câu ví dụ bị khuyết từ hoặc nghĩa tiếng Việt
                if (hasBlank) ...[
                  _buildSentenceWithBlank(colors),
                ] else ...[
                  // Hiển thị nghĩa TV làm đề bài
                  if (widget.exercise.vietnameseTranslation != null)
                    Text(
                      widget.exercise.vietnameseTranslation!,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: colors.textMain,
                        height: 1.35,
                      ),
                    ),
                ],

                // Hint khi bấm gợi ý
                if (widget.usedHint &&
                    widget.exercise.meaningHint != null) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: colors.brandSoft,
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(color: colors.brandBorder, width: 1.5),
                    ),
                    child: Text(
                      'Gợi ý: ${widget.exercise.meaningHint}',
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
          const SizedBox(height: 20),

          // Text input area
          ChunkyCard(
            fillColor: colors.surface,
            borderColor: widget.isSubmitted
                ? (widget.isCorrect ? colors.mint : colors.coral)
                : (_hasTyped ? colors.brand : colors.border),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nhập từ vựng chính xác:',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: colors.textSub,
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: !widget.isSubmitted,
                  autofocus: false,
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: widget.isSubmitted
                        ? (widget.isCorrect
                            ? const Color(0xFF007A55)
                            : colors.coral)
                        : colors.textMain,
                    letterSpacing: 1.2,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Gõ từ vựng ở đây...',
                    hintStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: colors.textSub.withValues(alpha: 0.5),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    suffixIcon: widget.isSubmitted
                        ? Icon(
                            widget.isCorrect
                                ? Icons.check_circle_rounded
                                : Icons.cancel_rounded,
                            color: widget.isCorrect
                                ? colors.mint
                                : colors.coral,
                            size: 28,
                          )
                        : null,
                  ),
                  onChanged: (text) {
                    setState(() => _hasTyped = text.trim().isNotEmpty);
                  },
                  onSubmitted: (_) => _handleSubmit(),
                ),

                // Character count hint
                if (!widget.isSubmitted && _correctAnswer.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.info_outline_rounded,
                          size: 14, color: colors.textSub),
                      const SizedBox(width: 4),
                      Text(
                        '${_correctAnswer.length} ký tự',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.textSub,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Feedback banner
          if (widget.isSubmitted) ...[
            _buildFeedbackBanner(colors),
            const SizedBox(height: 16),
          ],

          // Submit button
          if (!widget.isSubmitted)
            ChunkyButton.mint(
              label: 'Kiểm tra',
              size: ChunkyButtonSize.large,
              onPressed: _hasTyped ? _handleSubmit : null,
            ),
        ],
      ),
    );
  }

  Widget _buildSentenceWithBlank(AppThemeColors colors) {
    final sentence = widget.exercise.targetSentence;
    final blankRegex = RegExp(r'_{2,}');
    
    String prefix = '';
    String suffix = '';

    if (sentence.contains(blankRegex)) {
      final parts = sentence.split(blankRegex);
      prefix = parts.isNotEmpty ? parts.first : '';
      suffix = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    } else {
      final targetToken = _correctAnswer;
      if (targetToken.isNotEmpty) {
        final wordRegex = RegExp('\\b${RegExp.escape(targetToken)}\\b', caseSensitive: false);
        final match = wordRegex.firstMatch(sentence);
        if (match != null) {
          prefix = sentence.substring(0, match.start);
          suffix = sentence.substring(match.end);
        } else {
          final idx = sentence.toLowerCase().indexOf(targetToken.toLowerCase());
          if (idx != -1) {
            prefix = sentence.substring(0, idx);
            suffix = sentence.substring(idx + targetToken.length);
          } else {
            prefix = sentence;
          }
        }
      } else {
        prefix = sentence;
      }
    }

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
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: widget.isSubmitted
                    ? (widget.isCorrect
                        ? const Color(0xFFE8FAF4)
                        : const Color(0xFFFFF1F4))
                    : colors.brandSoft,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: widget.isSubmitted
                      ? (widget.isCorrect ? colors.mint : colors.coral)
                      : colors.brandBorder,
                  width: 2,
                ),
              ),
              child: Text(
                widget.isSubmitted
                    ? (_controller.text.isNotEmpty
                        ? _controller.text
                        : '______')
                    : '______',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: widget.isSubmitted
                      ? (widget.isCorrect
                          ? const Color(0xFF007A55)
                          : colors.coral)
                      : colors.brand,
                ),
              ),
            ),
          ),
          TextSpan(text: suffix),
        ],
      ),
    );
  }

  Widget _buildFeedbackBanner(AppThemeColors colors) {
    return ChunkyCard(
      fillColor: widget.isCorrect
          ? (context.isDarkMode
              ? const Color(0xFF0F392B)
              : const Color(0xFFE8FAF4))
          : (context.isDarkMode
              ? const Color(0xFF3E1C27)
              : const Color(0xFFFFF1F4)),
      borderColor: widget.isCorrect ? colors.mint : colors.coral,
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: widget.isCorrect ? colors.mint : colors.coral,
              shape: BoxShape.circle,
            ),
            child: Icon(
              widget.isCorrect
                  ? Icons.check_rounded
                  : Icons.close_rounded,
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
                  widget.isCorrect
                      ? 'Xuất sắc! Chính xác!'
                      : 'Chưa đúng rồi!',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: widget.isCorrect ? colors.mint : colors.coral,
                  ),
                ),
                if (!widget.isCorrect) ...[
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: colors.coral,
                      ),
                      children: [
                        const TextSpan(text: 'Đáp án: '),
                        TextSpan(
                          text: '"$_correctAnswer"',
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Hiển thị so sánh ký tự nếu user đã gõ
                  if (_controller.text.trim().isNotEmpty) ...[
                    const SizedBox(height: 6),
                    _buildCharComparison(colors),
                  ],
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.volume_up_rounded,
              color: widget.isCorrect ? colors.mint : colors.coral,
              size: 24,
            ),
            tooltip: 'Nghe phát âm',
            onPressed: () {
              ref.read(ttsServiceProvider).speak(
                    text: _correctAnswer,
                  );
            },
          ),
        ],
      ),
    );
  }

  /// Highlight từng ký tự đúng/sai để người dùng thấy rõ lỗi chính tả
  Widget _buildCharComparison(AppThemeColors colors) {
    final userText = _controller.text.trim().toLowerCase();
    final correctText = _correctAnswer.toLowerCase();
    final maxLen =
        userText.length > correctText.length ? userText.length : correctText.length;

    return Wrap(
      spacing: 1,
      children: List.generate(maxLen, (i) {
        final userChar = i < userText.length ? userText[i] : '';
        final correctChar = i < correctText.length ? correctText[i] : '';
        final isMatch = userChar == correctChar;

        return Container(
          width: 22,
          height: 28,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isMatch
                ? const Color(0xFFE8FAF4)
                : const Color(0xFFFFF1F4),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: isMatch ? colors.mint : colors.coral,
              width: 1.5,
            ),
          ),
          child: Text(
            i < userText.length ? userText[i] : '·',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w800,
              color: isMatch
                  ? const Color(0xFF007A55)
                  : colors.coral,
            ),
          ),
        );
      }),
    );
  }
}
