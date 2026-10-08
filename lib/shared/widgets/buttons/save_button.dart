import 'package:flutter/material.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

/// Nút Lưu dạng Duolingo 3D (Chunky Style)
class SaveButton extends StatelessWidget {
  final bool isSaving;
  final VoidCallback? onPressed;
  final String label;

  const SaveButton({
    super.key,
    required this.isSaving,
    this.onPressed,
    this.label = 'Lưu',
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
      child: ChunkyButton(
        label: label,
        isLoading: isSaving,
        onPressed: isSaving ? null : onPressed,
        size: ChunkyButtonSize.large,
      ),
    );
  }
}
