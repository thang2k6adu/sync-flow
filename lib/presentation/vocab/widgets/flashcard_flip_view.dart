import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/study_item.dart';
import 'package:pp191225/providers/datasources_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Flashcard phong cách Duolingo: thẻ trắng/viền xám, chữ Poppins đậm,
/// nút loa viền, lật 3D có haptic. Tự thích ứng Light/Dark qua themeColors.
class FlashcardFlipView extends ConsumerWidget {
  final StudyItem item;
  final bool isFlipped;
  final VoidCallback onFlip;

  const FlashcardFlipView({
    super.key,
    required this.item,
    required this.isFlipped,
    required this.onFlip,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onFlip();
      },
      behavior: HitTestBehavior.opaque,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        tween: Tween<double>(begin: 0, end: isFlipped ? 180 : 0),
        builder: (context, double value, child) {
          final isBack = value >= 90;
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY((value * pi) / 180),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: ChunkyCard(
                depth: 4,
                radius: 20,
                fillColor: colors.surface,
                borderColor: colors.borderStrong,
                padding: EdgeInsets.zero,
                child: SizedBox(
                  height: 420,
                  child: isBack
                      ? Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.identity()..rotateY(pi),
                          child: _buildBackContent(context, ref, colors),
                        )
                      : _buildFrontContent(context, ref, colors),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// Mặt trước kiểu Duolingo: từ lớn căn giữa + phonetic + nút loa viền.
  Widget _buildFrontContent(
      BuildContext context, WidgetRef ref, AppThemeColors colors) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: colors.brandSoft,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: colors.brandBorder, width: 1.5),
            ),
            child: Text(
              'CẤP ĐỘ SRS: ${item.masteryLevel}'.toUpperCase(),
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: colors.brand,
                letterSpacing: 0.8,
              ),
            ),
          ),
          const Spacer(),
          Text(
            item.term,
            textAlign: TextAlign.center,
            style: (textTheme.displayLarge ??
                    const TextStyle(fontSize: 36, fontWeight: FontWeight.w700))
                .copyWith(
              fontFamily: AppFonts.poppins,
              fontSize: 38,
              fontWeight: FontWeight.w700,
              height: 1.15,
              letterSpacing: -0.2,
              color: colors.textMain,
            ),
          ),
          if (item.phonetic != null && item.phonetic!.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              item.phonetic!,
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 17,
                color: colors.textSub,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          const SizedBox(height: 18),
          ChunkyButton.outlined(
            label: 'Nghe phát âm',
            icon: Icons.volume_up_rounded,
            size: ChunkyButtonSize.small,
            radius: 999,
            onPressed: () {
              ref.read(ttsServiceProvider).speak(
                    text: item.term,
                    audioUrl: item.audioUrl,
                  );
            },
          ),
          const Spacer(),
          Divider(height: 1, thickness: 1.5, color: colors.border),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.touch_app_rounded, size: 18, color: colors.textSub),
              const SizedBox(width: 6),
              Text(
                'Chạm vào thẻ để lật xem nghĩa',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: 13,
                  color: colors.textSub,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackContent(
      BuildContext context, WidgetRef ref, AppThemeColors colors) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.term,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: colors.textMain,
                      ),
                    ),
                    if (item.phonetic != null && item.phonetic!.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.phonetic!,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14,
                          color: colors.textSub,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              ChunkyIconButton.circle(
                icon: Icons.volume_up_rounded,
                tooltip: 'Nghe phát âm từ',
                size: ChunkyButtonSize.small,
                onPressed: () {
                  ref.read(ttsServiceProvider).speak(
                        text: item.term,
                        audioUrl: item.audioUrl,
                      );
                },
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, thickness: 2, color: colors.border),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: item.meanings.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final m = item.meanings[index];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (m.pos != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              color: colors.brandSoft,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colors.brandBorder, width: 1.5),
                            ),
                            child: Text(
                              m.pos!.toUpperCase(),
                              style: TextStyle(
                                fontFamily: AppFonts.poppins,
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.5,
                                color: colors.brand,
                              ),
                            ),
                          ),
                        Expanded(
                          child: Text(
                            m.meaningVi,
                            style: TextStyle(
                              fontFamily: AppFonts.poppins,
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              height: 1.35,
                              color: colors.textMain,
                            ),
                          ),
                        ),
                      ],
                    ),
                    if (m.definitionEn != null && m.definitionEn!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        m.definitionEn!,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 13,
                          color: colors.textSub,
                          fontWeight: FontWeight.w500,
                          height: 1.4,
                        ),
                      ),
                    ],
                    if (m.exampleEn != null && m.exampleEn!.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: colors.surfaceMuted,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: colors.border, width: 1.5),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    '“${m.exampleEn!}”',
                                    style: TextStyle(
                                      fontFamily: AppFonts.poppins,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      height: 1.4,
                                      color: colors.textMain,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                InkWell(
                                  onTap: () {
                                    HapticFeedback.lightImpact();
                                    ref.read(ttsServiceProvider).speak(text: m.exampleEn!);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  child: Padding(
                                    padding: const EdgeInsets.all(4),
                                    child: Icon(
                                      Icons.volume_up_outlined,
                                      size: 18,
                                      color: colors.brand,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (m.exampleVi != null && m.exampleVi!.isNotEmpty) ...[
                              const SizedBox(height: 2),
                              Text(
                                m.exampleVi!,
                                style: TextStyle(
                                  fontFamily: AppFonts.poppins,
                                  fontSize: 13,
                                  color: colors.textSub,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
