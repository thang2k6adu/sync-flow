import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';

class AchievementList extends StatelessWidget {
  final UserProgression progression;

  const AchievementList({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    final achievements = [
      _AchievementData(
        title: 'Khởi đầu nan',
        desc: 'Thực hiện lượt ôn tập từ vựng đầu tiên',
        icon: Icons.rocket_launch_outlined,
        isUnlocked: progression.totalReviews >= 1,
      ),
      _AchievementData(
        title: 'Ngọn lửa kiên trì',
        desc: 'Duy trì chuỗi học liên tục từ 3 ngày trở lên',
        icon: Icons.local_fire_department,
        isUnlocked: progression.streak >= 3,
      ),
      _AchievementData(
        title: 'Kho từ phong phú',
        desc: 'Thuần thục từ 10 từ vựng SRS',
        icon: Icons.auto_stories,
        isUnlocked: progression.wordsMastered >= 10,
      ),
      _AchievementData(
        title: 'Bậc thầy tri thức',
        desc: 'Đạt Cấp độ 3 (Tinh Anh)',
        icon: Icons.military_tech,
        isUnlocked: progression.level >= 3,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Huy hiệu thành tích',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.neutral900,
                ),
              ),
              Text(
                '${achievements.where((a) => a.isUnlocked).length}/${achievements.length} Đã mở',
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: achievements.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final a = achievements[index];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: a.isUnlocked ? Colors.white : AppColors.slate[1],
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: a.isUnlocked
                        ? AppColors.primary.withOpacity(0.3)
                        : AppColors.neutral200,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: a.isUnlocked
                            ? AppColors.secondary
                            : AppColors.slate[2],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        a.icon,
                        color: a.isUnlocked
                            ? AppColors.primary
                            : AppColors.neutral500,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            a.title,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: a.isUnlocked
                                  ? AppColors.neutral900
                                  : AppColors.neutral500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            a.desc,
                            style: TextStyle(
                              fontSize: 12,
                              color: a.isUnlocked
                                  ? AppColors.neutral700
                                  : AppColors.neutral500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (a.isUnlocked)
                      const Icon(Icons.check_circle, color: Colors.green, size: 20)
                    else
                      const Icon(Icons.lock_outline, color: AppColors.neutral500, size: 20),
                  ],
                ),
              );
            },
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
  final bool isUnlocked;

  _AchievementData({
    required this.title,
    required this.desc,
    required this.icon,
    required this.isUnlocked,
  });
}
