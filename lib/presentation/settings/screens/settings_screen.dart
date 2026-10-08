import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/settings/controllers/settings_controller.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  static const _goalOptions = [5, 10, 15, 20, 30];

  void _confirmLogout(BuildContext context, WidgetRef ref) {
    final colors = context.themeColors;
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: colors.border, width: 2),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Đăng xuất?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: colors.textMain,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Bạn sẽ cần đăng nhập lại để tiếp tục học.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colors.textSub,
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
                textColor: colors.coral,
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
    final colors = context.themeColors;
    final settings = ref.watch(settingsControllerProvider);
    final controller = ref.read(settingsControllerProvider.notifier);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        title: Text(
          'Cài đặt',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: colors.textMain,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Divider(height: 2, thickness: 2, color: colors.border),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
        children: [
          // Mục Giao diện (Light Mode / Dark Mode / System)
          const _SectionTitle('Giao diện'),
          _ThemeModeSelector(
            selectedMode: ref.watch(
              settingsControllerProvider.select((s) => s.themeMode),
            ),
            onChanged: (mode) => controller.updateThemeMode(mode),
          ),
          const SizedBox(height: 28),

          const _SectionTitle('Mục tiêu học tập'),
          ChunkyCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Số từ mỗi ngày',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: colors.textMain,
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
                  color: colors.brand,
                  title: 'Tự động phát âm',
                  subtitle: 'Đọc từ khi lật thẻ',
                  value: settings.autoPlayAudio,
                  onChanged: (_) => controller.toggleAutoPlayAudio(),
                ),
                const _RowDivider(),
                _SwitchRow(
                  icon: Icons.vibration_rounded,
                  color: colors.brand,
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
                  color: colors.brand,
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
                          _IconBadge(
                            icon: Icons.access_time_filled_rounded,
                            color: colors.brand,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Text(
                              'Giờ nhắc',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: colors.textMain,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: colors.surfaceMuted,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: colors.border,
                                width: 2,
                              ),
                            ),
                            child: Text(
                              settings.reminderTime,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: colors.brand,
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
            textColor: colors.coral,
            onPressed: () => _confirmLogout(context, ref),
          ),
          const SizedBox(height: 24),
          Text(
            'Sync Flow  •  v1.0.0',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: colors.textSub,
            ),
          ),
        ],
      ),
    );
  }
}

class _ThemeModeSelector extends StatelessWidget {
  final ThemeMode selectedMode;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeModeSelector({
    required this.selectedMode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final options = [
      (
        mode: ThemeMode.system,
        label: 'Tự động',
        icon: Icons.brightness_auto_rounded,
      ),
      (
        mode: ThemeMode.light,
        label: 'Sáng',
        icon: Icons.light_mode_rounded,
      ),
      (
        mode: ThemeMode.dark,
        label: 'Tối',
        icon: Icons.dark_mode_rounded,
      ),
    ];

    return ChunkyCard(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          for (int i = 0; i < options.length; i++) ...[
            if (i > 0) const SizedBox(width: 8),
            Expanded(
              child: _ThemeModeOptionCard(
                icon: options[i].icon,
                label: options[i].label,
                isSelected: selectedMode == options[i].mode,
                onTap: () => onChanged(options[i].mode),
                colors: colors,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ThemeModeOptionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AppThemeColors colors;

  const _ThemeModeOptionCard({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ChunkyCard(
      onTap: onTap,
      radius: 12,
      depth: isSelected ? 3 : 2,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      fillColor: isSelected ? colors.brandSoft : colors.surfaceMuted,
      borderColor: isSelected ? colors.brandBorder : colors.border,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 24,
            color: isSelected ? colors.brand : colors.textSub,
          ),
          const SizedBox(height: 6),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isSelected ? colors.brand : colors.textSub,
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
    final colors = context.themeColors;
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: colors.textMain,
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    return Divider(height: 2, thickness: 2, color: colors.border);
  }
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
    final colors = context.themeColors;
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
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: colors.textMain,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: colors.textSub,
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
              activeTrackColor: colors.brand,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: context.isDarkMode
                  ? const Color(0xFF433F60)
                  : const Color(0xFFCFCFCF),
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
    final colors = context.themeColors;
    return ChunkyCard(
      onTap: onTap,
      radius: 12,
      depth: 3,
      padding: const EdgeInsets.symmetric(vertical: 10),
      fillColor: selected ? colors.brandSoft : colors.surface,
      borderColor: selected ? colors.brandBorder : colors.border,
      child: Center(
        child: Text(
          '$value',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: selected ? colors.brand : colors.textSub,
          ),
        ),
      ),
    );
  }
}
