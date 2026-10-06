import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/settings/controllers/settings_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _goalOptions = [5, 10, 15, 20, 30];

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Đăng xuất?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: ChunkyColors.textMain,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Bạn sẽ cần đăng nhập lại để tiếp tục học.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ChunkyColors.textSub,
                ),
              ),
              const SizedBox(height: 24),
              ChunkyButton(
                label: 'Ở lại',
                onPressed: () => Navigator.pop(ctx),
              ),
              const SizedBox(height: 8),
              ChunkyButton.outlined(
                label: 'Đăng xuất',
                textColor: ChunkyColors.red,
                onPressed: () async {
                  Navigator.pop(ctx);
                  await ref.read(authControllerProvider.notifier).logout(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: const Text(
          'Cài đặt',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: ChunkyColors.textMain,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: ChunkyColors.border),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        children: [
          const _SectionTitle('Mục tiêu học tập'),
          ChunkyCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Số từ mỗi ngày',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: ChunkyColors.textMain,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    for (int i = 0; i < _goalOptions.length; i++) ...[
                      if (i > 0) const SizedBox(width: 8),
                      Expanded(
                        child: _GoalChip(
                          value: _goalOptions[i],
                          selected: settings.dailyWordGoal == _goalOptions[i],
                          onTap: () => controller.updateDailyGoal(_goalOptions[i]),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          const _SectionTitle('Trải nghiệm'),
          ChunkyCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SwitchRow(
                  icon: Icons.volume_up_rounded,
                  color: ChunkyColors.brand,
                  title: 'Tự động phát âm',
                  subtitle: 'Đọc từ khi lật thẻ',
                  value: settings.autoPlayAudio,
                  onChanged: (_) => controller.toggleAutoPlayAudio(),
                ),
                const _RowDivider(),
                _SwitchRow(
                  icon: Icons.vibration_rounded,
                  color: ChunkyColors.brand,
                  title: 'Rung phản hồi',
                  subtitle: 'Rung nhẹ khi chọn đáp án',
                  value: settings.hapticFeedback,
                  onChanged: (_) => controller.toggleHapticFeedback(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          const _SectionTitle('Nhắc nhở'),
          ChunkyCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _SwitchRow(
                  icon: Icons.notifications_rounded,
                  color: ChunkyColors.brand,
                  title: 'Nhắc học hằng ngày',
                  subtitle: 'Giữ chuỗi ngày học của bạn',
                  value: settings.dailyReminderEnabled,
                  onChanged: (_) => controller.toggleDailyReminder(),
                ),
                if (settings.dailyReminderEnabled) ...[
                  const _RowDivider(),
                  InkWell(
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
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const _IconBadge(
                            icon: Icons.access_time_filled_rounded,
                            color: ChunkyColors.brand,
                          ),
                          const SizedBox(width: 14),
                          const Expanded(
                            child: Text(
                              'Giờ nhắc',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: ChunkyColors.textMain,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: ChunkyColors.surfaceMuted,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: ChunkyColors.border,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              settings.reminderTime,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: ChunkyColors.brand,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 28),

          const _SectionTitle('Tài khoản'),
          ChunkyButton.outlined(
            label: 'Đăng xuất',
            textColor: ChunkyColors.red,
            onPressed: () => _confirmLogout(context, ref),
          ),
          const SizedBox(height: 24),
          const Center(
            child: Text(
              'Sync Flow  •  v1.0.0',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Color(0xFFAFAFAF),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: ChunkyColors.textMain,
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) =>
      const Divider(height: 2, thickness: 2, color: ChunkyColors.border);
}

class _IconBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  const _IconBadge({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: Colors.white, size: 22),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SwitchRow({
    required this.icon,
    required this.color,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            _IconBadge(icon: icon, color: color),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ChunkyColors.textMain,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: ChunkyColors.textSub,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: Colors.white,
              activeTrackColor: ChunkyColors.brand,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: const Color(0xFFCFCFCF),
              trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalChip extends StatelessWidget {
  final int value;
  final bool selected;
  final VoidCallback onTap;

  const _GoalChip({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ChunkyCard(
      onTap: onTap,
      radius: 12,
      depth: 3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      fillColor: selected ? ChunkyColors.brandSoft : Colors.white,
      borderColor: selected ? ChunkyColors.brandBorder : ChunkyColors.border,
      child: Center(
        child: Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: selected ? ChunkyColors.brand : ChunkyColors.textSub,
          ),
        ),
      ),
    );
  }
}
