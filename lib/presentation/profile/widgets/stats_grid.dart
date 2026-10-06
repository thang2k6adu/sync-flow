import 'package:flutter/material.dart';
import 'package:pp191225/domain/entities/progression/user_progression.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class StatsGrid extends StatelessWidget {
  final UserProgression progression;

  const StatsGrid({super.key, required this.progression});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Thống kê',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ChunkyColors.textMain,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.local_fire_department_rounded,
                color: ChunkyColors.orange,
                value: '${progression.streak}',
                label: 'Ngày liên tiếp',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.bolt_rounded,
                color: ChunkyColors.yellow,
                value: '${progression.totalExp}',
                label: 'Tổng EXP',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _StatCard(
                icon: Icons.check_circle_rounded,
                color: ChunkyColors.green,
                value: '${progression.wordsMastered}',
                label: 'Từ đã thuộc',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                icon: Icons.replay_rounded,
                color: ChunkyColors.brand,
                value: '${progression.totalReviews}',
                label: 'Lượt ôn tập',
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.color,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ChunkyCard(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    height: 1.2,
                    fontWeight: FontWeight.w700,
                    color: color == ChunkyColors.yellow ? ChunkyColors.amberText : color,
                  ),
                ),
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: ChunkyColors.textSub,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
