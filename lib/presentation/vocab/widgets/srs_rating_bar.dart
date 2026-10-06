import 'package:flutter/material.dart';

class SrsRatingBar extends StatelessWidget {
  final Function(String rating) onRating;

  const SrsRatingBar({
    super.key,
    required this.onRating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildRatingButton(
              label: 'Lại',
              subLabel: '< 10p',
              color: const Color(0xFFEF4444),
              onTap: () => onRating('AGAIN'),
            ),
            const SizedBox(width: 8),
            _buildRatingButton(
              label: 'Khó',
              subLabel: '1 ngày',
              color: const Color(0xFFF59E0B),
              onTap: () => onRating('HARD'),
            ),
            const SizedBox(width: 8),
            _buildRatingButton(
              label: 'Tốt',
              subLabel: '3 ngày',
              color: const Color(0xFF3B82F6),
              onTap: () => onRating('GOOD'),
            ),
            const SizedBox(width: 8),
            _buildRatingButton(
              label: 'Dễ',
              subLabel: '5 ngày',
              color: const Color(0xFF10B981),
              onTap: () => onRating('EASY'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingButton({
    required String label,
    required String subLabel,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: color.withOpacity(0.4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subLabel,
                style: TextStyle(
                  fontSize: 11,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
