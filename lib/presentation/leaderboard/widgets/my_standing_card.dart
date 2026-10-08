import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class MyStandingCard extends StatelessWidget {
  final LeaderboardEntry myStanding;

  const MyStandingCard({
    super.key,
    required this.myStanding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ChunkyCard(
        padding: const EdgeInsets.all(16),
        fillColor: colors.surface,
        borderColor: colors.brand.withOpacity(0.35),
        child: Column(
          children: [
            // Thông tin cá nhân
            Row(
              children: [
                // Avatar
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: colors.brand, width: 2),
                  ),
                  child: ClipOval(
                    child: myStanding.avatar != null && myStanding.avatar!.isNotEmpty
                        ? Image.network(
                            myStanding.avatar!,
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
                        myStanding.name,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: colors.textMain,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        myStanding.rankTitle,
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                          color: colors.brand,
                        ),
                      ),
                    ],
                  ),
                ),

                // Thẻ điểm EXP
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: colors.amber.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bolt_rounded, size: 16, color: colors.amber),
                      const SizedBox(width: 4),
                      Text(
                        '${myStanding.exp} EXP',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w800,
                          fontSize: 12,
                          color: colors.textMain,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Hộp nổi bật vị trí & xu hướng thăng hạng (như ảnh 2)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: colors.mint.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: colors.mint.withOpacity(0.25),
                  width: 1,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Thứ hạng hiện tại
                  Row(
                    children: [
                      Text(
                        'Vị trí của bạn: ',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: colors.textSub,
                        ),
                      ),
                      Text(
                        'Hạng #${myStanding.rank}',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: colors.textMain,
                        ),
                      ),
                    ],
                  ),

                  // Tăng trưởng
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: colors.mint.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.trending_up_rounded, size: 15, color: colors.mintDark),
                        const SizedBox(width: 4),
                        Text(
                          '↑ ${myStanding.rankDiff} bậc',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: colors.mintDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFallback(AppThemeColors colors) {
    return Container(
      color: colors.brandSoft,
      alignment: Alignment.center,
      child: Text(
        myStanding.name.isNotEmpty ? myStanding.name.substring(0, 1).toUpperCase() : 'U',
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w800,
          color: colors.brand,
          fontSize: 18,
        ),
      ),
    );
  }
}
