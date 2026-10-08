import 'package:flutter/material.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class LevelProgressCard extends StatelessWidget {
  final UserProgression progression;

  const LevelProgressCard({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final remaining = progression.expToNextLevel - progression.currentExp;

    return ChunkyCard(
      fillColor: colors.brand,
      borderColor: colors.brandDark,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'CẤP ${progression.level}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            progression.rankTitle,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 18),
          ChunkyProgressBar(
            value: progression.progress,
            color: colors.amber,
            trackColor: colors.brandDark,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${progression.currentExp} / ${progression.expToNextLevel} EXP',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Còn $remaining EXP',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
