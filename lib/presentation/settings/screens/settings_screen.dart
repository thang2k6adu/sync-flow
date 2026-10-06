import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_colors.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/settings/controllers/settings_controller.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Đăng xuất'),
        content: const Text('Cậu có chắc chắn muốn đăng xuất khỏi ứng dụng không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Huỷ'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(ctx);
              await ref.read(authControllerProvider.notifier).logout(context);
            },
            child: const Text('Đăng xuất', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài Đặt', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          // Section 1: Tùy chỉnh học tập
          _buildSectionHeader('TÙY CHỈNH HỌC TẬP'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.flag_outlined, color: AppColors.primary),
                  title: const Text('Mục tiêu học mỗi ngày'),
                  subtitle: Text('${settings.dailyWordGoal} từ / ngày'),
                  trailing: DropdownButton<int>(
                    value: settings.dailyWordGoal,
                    underline: const SizedBox.shrink(),
                    items: [5, 10, 15, 20, 30]
                        .map((val) => DropdownMenuItem(value: val, child: Text('$val từ')))
                        .toList(),
                    onChanged: (val) {
                      if (val != null) controller.updateDailyGoal(val);
                    },
                  ),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.volume_up_outlined, color: AppColors.primary),
                  title: const Text('Tự động phát âm thanh'),
                  subtitle: const Text('Phát âm chuẩn khi lật thẻ từ vựng'),
                  value: settings.autoPlayAudio,
                  activeColor: AppColors.primary,
                  onChanged: (_) => controller.toggleAutoPlayAudio(),
                ),
                const Divider(height: 1),
                SwitchListTile(
                  secondary: const Icon(Icons.vibration_outlined, color: AppColors.primary),
                  title: const Text('Phản hồi rung'),
                  subtitle: const Text('Rung nhẹ khi chọn đáp án'),
                  value: settings.hapticFeedback,
                  activeColor: AppColors.primary,
                  onChanged: (_) => controller.toggleHapticFeedback(),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Section 2: Nhắc nhở & Thông báo
          _buildSectionHeader('NHẮC NHỞ HỌC TẬP'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Column(
              children: [
                SwitchListTile(
                  secondary: const Icon(Icons.notifications_active_outlined, color: AppColors.primary),
                  title: const Text('Nhắc nhở học hàng ngày'),
                  subtitle: const Text('Nhắc ôn từ vựng duy trì chuỗi Streak'),
                  value: settings.dailyReminderEnabled,
                  activeColor: AppColors.primary,
                  onChanged: (_) => controller.toggleDailyReminder(),
                ),
                if (settings.dailyReminderEnabled) ...[
                  const Divider(height: 1),
                  ListTile(
                    leading: const Icon(Icons.access_time_outlined, color: AppColors.primary),
                    title: const Text('Giờ nhắc nhở'),
                    trailing: Text(
                      settings.reminderTime,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppColors.primary,
                      ),
                    ),
                    onTap: () async {
                      final timeParts = settings.reminderTime.split(':');
                      final initialTime = TimeOfDay(
                        hour: int.tryParse(timeParts.first) ?? 20,
                        minute: int.tryParse(timeParts.last) ?? 0,
                      );

                      final picked = await showTimePicker(
                        context: context,
                        initialTime: initialTime,
                      );
                      if (picked != null) {
                        final formatted =
                            '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
                        controller.updateReminderTime(formatted);
                      }
                    },
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 24),
          // Section 3: Ứng dụng & Tài khoản
          _buildSectionHeader('HỆ THỐNG & TÀI KHOẢN'),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.neutral200),
            ),
            child: Column(
              children: [
                const ListTile(
                  leading: Icon(Icons.info_outline, color: AppColors.neutral700),
                  title: Text('Phiên bản ứng dụng'),
                  trailing: Text(
                    'v1.0.0 (Sync Flow)',
                    style: TextStyle(color: AppColors.neutral500),
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.logout, color: AppColors.error),
                  title: const Text(
                    'Đăng xuất',
                    style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                  ),
                  onTap: () => _confirmLogout(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: AppColors.neutral500,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}
