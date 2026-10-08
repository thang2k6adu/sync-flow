import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/presentation/vocab/widgets/create_deck_dialog.dart';

class HomeQuickGrid extends StatelessWidget {
  final List<Deck> decks;
  final VoidCallback onStartDueStudy;
  final VoidCallback onStartLeechRescue;

  const HomeQuickGrid({
    super.key,
    required this.decks,
    required this.onStartDueStudy,
    required this.onStartLeechRescue,
  });

  void _openDeckByName(BuildContext context, String keyword) {
    final found = decks.firstWhere(
      (d) => d.name.toLowerCase().contains(keyword.toLowerCase()),
      orElse: () => decks.isNotEmpty ? decks.first : const Deck(id: 'default', name: 'Mặc định'),
    );
    if (found.id != 'default') {
      context.push(RouteConstants.deckDetail, extra: found);
    } else {
      context.push(RouteConstants.studySession);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final List<_QuickItemData> items = [
      _QuickItemData(
        title: 'Ôn tập SRS',
        subtitle: 'Thẻ đến hạn',
        icon: Icons.bolt_rounded,
        iconColor: colors.amber,
        bgColor: colors.amber.withOpacity(0.08),
        onTap: onStartDueStudy,
      ),
      _QuickItemData(
        title: 'Cứu từ Leech',
        subtitle: 'Từ hay quên',
        icon: Icons.healing_rounded,
        iconColor: colors.coral,
        bgColor: colors.coral.withOpacity(0.08),
        onTap: onStartLeechRescue,
      ),
      _QuickItemData(
        title: 'Luyện gõ từ',
        subtitle: 'Phản xạ typing',
        icon: Icons.keyboard_rounded,
        iconColor: colors.brand,
        bgColor: colors.brand.withOpacity(0.08),
        onTap: () {
          context.push(RouteConstants.studySession);
        },
      ),
      _QuickItemData(
        title: '3000 Oxford',
        subtitle: 'Bộ từ chuẩn B1',
        icon: Icons.menu_book_rounded,
        iconColor: const Color(0xFF0284C7),
        bgColor: const Color(0xFF0284C7).withOpacity(0.08),
        onTap: () => _openDeckByName(context, 'oxford'),
      ),
      _QuickItemData(
        title: 'Giao tiếp',
        subtitle: 'Mẫu câu ngày',
        icon: Icons.forum_rounded,
        iconColor: colors.mintDark,
        bgColor: colors.mint.withOpacity(0.08),
        onTap: () => _openDeckByName(context, 'giao tiếp'),
      ),
      _QuickItemData(
        title: 'Tạo bộ từ',
        subtitle: 'Thêm sổ tay mới',
        icon: Icons.add_circle_outline_rounded,
        iconColor: colors.brand,
        bgColor: colors.brandSoft,
        onTap: () {
          showDialog(
            context: context,
            builder: (_) => const CreateDeckDialog(),
          );
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.dashboard_customize_rounded, size: 18, color: colors.brand),
              const SizedBox(width: 8),
              Text(
                'Lối tắt học tập',
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: colors.textMain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // Lưới 3 x 2
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.95,
            ),
            itemBuilder: (context, index) {
              final item = items[index];
              return _QuickGridTile(item: item);
            },
          ),
        ],
      ),
    );
  }
}

class _QuickItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color bgColor;
  final VoidCallback onTap;

  const _QuickItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.bgColor,
    required this.onTap,
  });
}

class _QuickGridTile extends StatelessWidget {
  final _QuickItemData item;

  const _QuickGridTile({required this.item});

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          HapticFeedback.lightImpact();
          item.onTap();
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colors.border,
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon container
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: item.bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  item.icon,
                  color: item.iconColor,
                  size: 22,
                ),
              ),
              const SizedBox(height: 8),

              // Tiêu đề
              Text(
                item.title,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: colors.textMain,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 2),

              // Phụ đề
              Text(
                item.subtitle,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: colors.textSub,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
