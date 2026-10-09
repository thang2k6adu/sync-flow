import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

class PodiumView extends StatelessWidget {
  final List<LeaderboardEntry> topThree;

  const PodiumView({super.key, required this.topThree});

  @override
  Widget build(BuildContext context) {
    if (topThree.isEmpty) return const SizedBox.shrink();

    // 1 người duy nhất (Hạng 1 ở giữa)
    if (topThree.length == 1) {
      final rank1 = topThree[0];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 130,
              child: _PodiumColumn(
                entry: rank1,
                podiumHeight: 130,
                badgeColor: const Color(0xFFFFB800), // Vàng
                badgeIcon: Icons.emoji_events_rounded,
                badgeLabel: '1',
                avatarSize: 66,
                isFirst: true,
              ),
            ),
          ],
        ),
      );
    }

    // 2 người (Hạng 1 và Hạng 2)
    if (topThree.length == 2) {
      final rank1 = topThree[0];
      final rank2 = topThree[1];
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: _PodiumColumn(
                entry: rank1,
                podiumHeight: 130,
                badgeColor: const Color(0xFFFFB800), // Vàng
                badgeIcon: Icons.emoji_events_rounded,
                badgeLabel: '1',
                avatarSize: 66,
                isFirst: true,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _PodiumColumn(
                entry: rank2,
                podiumHeight: 110,
                badgeColor: const Color(0xFFA0AEC0), // Bạc
                badgeIcon: Icons.workspace_premium_rounded,
                badgeLabel: '2',
                avatarSize: 56,
              ),
            ),
          ],
        ),
      );
    }

    // Đủ 3 người (Rank 3 - 1 - 2)
    final rank1 = topThree[0];
    final rank2 = topThree[1];
    final rank3 = topThree[2];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Bục Hạng 3 (Bên trái)
          Expanded(
            child: _PodiumColumn(
              entry: rank3,
              podiumHeight: 92,
              badgeColor: const Color(0xFFCD7F32), // Đồng
              badgeIcon: Icons.military_tech_rounded,
              badgeLabel: '3',
              avatarSize: 52,
            ),
          ),
          const SizedBox(width: 8),

          // Bục Hạng 1 (Ở giữa - cao nhất)
          Expanded(
            child: _PodiumColumn(
              entry: rank1,
              podiumHeight: 130,
              badgeColor: const Color(0xFFFFB800), // Vàng
              badgeIcon: Icons.emoji_events_rounded,
              badgeLabel: '1',
              avatarSize: 66,
              isFirst: true,
            ),
          ),
          const SizedBox(width: 8),

          // Bục Hạng 2 (Bên phải)
          Expanded(
            child: _PodiumColumn(
              entry: rank2,
              podiumHeight: 110,
              badgeColor: const Color(0xFFA0AEC0), // Bạc
              badgeIcon: Icons.workspace_premium_rounded,
              badgeLabel: '2',
              avatarSize: 56,
            ),
          ),
        ],
      ),
    );
  }
}

class _PodiumColumn extends StatelessWidget {
  final LeaderboardEntry entry;
  final double podiumHeight;
  final Color badgeColor;
  final IconData badgeIcon;
  final String badgeLabel;
  final double avatarSize;
  final bool isFirst;

  const _PodiumColumn({
    required this.entry,
    required this.podiumHeight,
    required this.badgeColor,
    required this.badgeIcon,
    required this.badgeLabel,
    required this.avatarSize,
    this.isFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Huy chương / vương miện trên đầu avatar
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: badgeColor.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(badgeIcon, color: badgeColor, size: isFirst ? 22 : 18),
        ),
        const SizedBox(height: 4),

        // Avatar
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isFirst
                      ? const Color(0xFFFFB800)
                      : colors.borderStrong,
                  width: isFirst ? 2.5 : 2,
                ),
                boxShadow: isFirst
                    ? [
                        BoxShadow(
                          color: const Color(0xFFFFB800).withValues(alpha: 0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: ClipOval(
                child: entry.avatar != null && entry.avatar!.isNotEmpty
                    ? Image.network(
                        entry.avatar!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => _buildAvatarFallback(colors),
                      )
                    : _buildAvatarFallback(colors),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),

        // Tên học viên
        Text(
          entry.name,
          style: TextStyle(
            fontFamily: AppFonts.poppins,
            fontWeight: FontWeight.w700,
            fontSize: isFirst ? 13 : 12,
            color: colors.textMain,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),

        // EXP & Chi tiết
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bolt_rounded, size: 14, color: colors.amber),
            Text(
              '${entry.exp}',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontWeight: FontWeight.w800,
                fontSize: 11,
                color: colors.textMain,
              ),
            ),
          ],
        ),
        Text(
          '${entry.masteredWords} từ',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: colors.textSub,
          ),
        ),
        const SizedBox(height: 8),

        // Cột bục đứng (Podium Block)
        Container(
          width: double.infinity,
          height: podiumHeight,
          decoration: BoxDecoration(
            color: isFirst
                ? colors.brand.withValues(alpha: 0.12)
                : colors.surfaceMuted,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(
              color: isFirst
                  ? colors.brand.withValues(alpha: 0.3)
                  : colors.border,
              width: 1.5,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                badgeLabel,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontSize: isFirst ? 32 : 26,
                  fontWeight: FontWeight.w900,
                  color: isFirst ? colors.brand : colors.textSub,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarFallback(AppThemeColors colors) {
    return Container(
      color: colors.brandSoft,
      alignment: Alignment.center,
      child: Text(
        entry.name.isNotEmpty ? entry.name.substring(0, 1).toUpperCase() : 'U',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w800,
          color: colors.brand,
          fontSize: isFirst ? 20 : 16,
        ),
      ),
    );
  }
}
