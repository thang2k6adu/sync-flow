import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class AchievementList extends StatelessWidget {
  final UserProgression progression;

  const AchievementList({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final achievements = [
      _AchievementData(
        title: 'Khởi đầu nan',
        desc: 'Thực hiện lượt ôn tập từ vựng đầu tiên',
        icon: Icons.rocket_launch_rounded,
        color: colors.brand,
        current: progression.totalReviews,
        target: 1,
      ),
      _AchievementData(
        title: 'Ngọn lửa kiên trì',
        desc: 'Duy trì chuỗi học liên tục 3 ngày',
        icon: Icons.local_fire_department_rounded,
        color: colors.coral,
        current: progression.streak,
        target: 3,
      ),
      _AchievementData(
        title: 'Kho từ phong phú',
        desc: 'Thuộc 10 từ vựng',
        icon: Icons.auto_stories_rounded,
        color: colors.mint,
        current: progression.wordsMastered,
        target: 10,
      ),
      _AchievementData(
        title: 'Bậc thầy tri thức',
        desc: 'Đạt cấp độ 3 (Tinh Anh)',
        icon: Icons.military_tech_rounded,
        color: colors.amber,
        current: progression.level,
        target: 3,
      ),
    ];

    final unlocked = achievements.where((a) => a.isUnlocked).length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Thành tích',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: colors.textMain,
                ),
              ),
            ),
            Text(
              '$unlocked/${achievements.length}',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: colors.textSub,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        ChunkyCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (int i = 0; i < achievements.length; i++) ...[
                if (i > 0)
                  Divider(height: 2, thickness: 2, color: colors.border),
                _AchievementRow(data: achievements[i]),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _AchievementRow extends StatelessWidget {
  final _AchievementData data;

  const _AchievementRow({required this.data});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final isDark = context.isDarkMode;
    final unlocked = data.isUnlocked;
    final accent = unlocked ? data.color : (isDark ? const Color(0xFF4A436C) : const Color(0xFFAFAFAF));

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: accent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              unlocked ? data.icon : Icons.lock_rounded,
              color: Colors.white,
              size: 28,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.desc,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: colors.textSub,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ChunkyProgressBar(
                        value: data.target == 0 ? 0 : data.current / data.target,
                        color: accent,
                        height: 10,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${data.current.clamp(0, data.target)}/${data.target}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: accent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AchievementData {
  final String title;
  final String desc;
  final IconData icon;
  final Color color;
  final int current;
  final int target;

  _AchievementData({
    required this.title,
    required this.desc,
    required this.icon,
    required this.color,
    required this.current,
    required this.target,
  });

  bool get isUnlocked => current >= target;
}
