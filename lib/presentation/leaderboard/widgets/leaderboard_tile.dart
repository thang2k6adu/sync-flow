import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';

class LeaderboardTile extends StatelessWidget {
  final LeaderboardEntry entry;

  const LeaderboardTile({
    super.key,
    required this.entry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: entry.isCurrentUser
            ? colors.brandSoft
            : colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: entry.isCurrentUser
              ? colors.brand.withOpacity(0.35)
              : colors.border,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Số thứ tự trong vòng tròn
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: entry.isCurrentUser
                  ? colors.brand
                  : colors.surfaceMuted,
              shape: BoxShape.circle,
            ),
            child: Text(
              '${entry.rank}',
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: entry.isCurrentUser
                    ? Colors.white
                    : colors.textSub,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Avatar
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: colors.border, width: 1.5),
            ),
            child: ClipOval(
              child: entry.avatar != null && entry.avatar!.isNotEmpty
                  ? Image.network(
                      entry.avatar!,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => _buildFallback(colors),
                    )
                  : _buildFallback(colors),
            ),
          ),
          const SizedBox(width: 12),

          // Tên & Danh hiệu
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.name,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: colors.textMain,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  entry.rankTitle,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontWeight: FontWeight.w500,
                    fontSize: 11,
                    color: colors.textSub,
                  ),
                ),
              ],
            ),
          ),

          // EXP & Thay đổi hạng
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.bolt_rounded, size: 14, color: colors.amber),
                  Text(
                    '${entry.exp}',
                    style: TextStyle(
                      fontFamily: AppFonts.poppins,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      color: colors.textMain,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 2),
              if (entry.rankDiff > 0)
                Text(
                  '↑ ${entry.rankDiff}',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: colors.mintDark,
                  ),
                )
              else if (entry.rankDiff < 0)
                Text(
                  '↓ ${entry.rankDiff.abs()}',
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: colors.coral,
                  ),
                )
              else
                Text(
                  '—',
                  style: TextStyle(
                    fontSize: 10,
                    color: colors.textSub,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFallback(AppThemeColors colors) {
    return Container(
      color: colors.brandSoft,
      alignment: Alignment.center,
      child: Text(
        entry.name.isNotEmpty ? entry.name.substring(0, 1).toUpperCase() : 'U',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w800,
          color: colors.brand,
          fontSize: 14,
        ),
      ),
    );
  }
}
