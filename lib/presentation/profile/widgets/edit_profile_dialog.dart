import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/providers/usecases_provider.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';
import 'package:pp191225/shared/widgets/feedback/overlay.dart';

class EditProfileDialog extends ConsumerStatefulWidget {
  final User user;

  const EditProfileDialog({super.key, required this.user});

  @override
  ConsumerState<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends ConsumerState<EditProfileDialog> {
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    if (name.isEmpty) return;

    setState(() => _isLoading = true);
    final overlay = UOverlay(context);
    final updateUseCase = ref.read(updateUserProfileUseCaseProvider);
    final result = await updateUseCase(name: name);

    if (mounted) {
      setState(() => _isLoading = false);
      result.fold(
        (failure) {
          overlay.showWithTimeout(
            message: 'Cập nhật thất bại',
          );
        },
        (updatedUser) {
          ref.read(authControllerProvider.notifier).setUser(updatedUser);
          Navigator.of(context).pop();
          overlay.showWithTimeout(message: 'Cập nhật hồ sơ thành công');
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Dialog(
      backgroundColor: colors.surface,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: colors.border, width: 2),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                'Chỉnh sửa hồ sơ',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: colors.textMain,
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Họ và tên',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: colors.border, width: 2),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: colors.border, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: colors.brand, width: 2),
                ),
                prefixIcon: Icon(Icons.person_rounded, color: colors.brand),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Email: ${widget.user.email}',
              style: TextStyle(fontSize: 13, color: colors.textSub, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            ChunkyButton(
              label: _isLoading ? 'Đang lưu...' : 'Lưu thay đổi',
              onPressed: _isLoading ? null : _submit,
            ),
            const SizedBox(height: 8),
            ChunkyButton.outlined(
              label: 'Huỷ bỏ',
              textColor: colors.textSub,
              onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
