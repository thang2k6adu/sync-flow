import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pp191225/core/constants/route_constants.dart';
import 'package:pp191225/core/theme/app_fonts.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';

class HomeCurvedHeader extends ConsumerStatefulWidget {
  final VoidCallback onStartDueStudy;

  const HomeCurvedHeader({
    super.key,
    required this.onStartDueStudy,
  });

  @override
  ConsumerState<HomeCurvedHeader> createState() => _HomeCurvedHeaderState();
}

class _HomeCurvedHeaderState extends ConsumerState<HomeCurvedHeader> {
  int _currentSlide = 0;

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Chào buổi sáng';
    if (hour < 18) return 'Chào buổi chiều';
    return 'Chào buổi tối';
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;
    final user = ref.watch(authControllerProvider);
    final progState = ref.watch(progressionControllerProvider);
    final progression = progState.progression;
    final summaryAsync = ref.watch(studySummaryProvider);

    final dueCount = summaryAsync.valueOrNull?.dueCount ?? 0;
    final leechCount = summaryAsync.valueOrNull?.leechCount ?? 0;

    final userName = (user != null && user.name.isNotEmpty) ? user.name : 'Người học';
    final initial = userName.substring(0, 1).toUpperCase();

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors.brandDark,
            colors.brand,
          ],
        ),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(32),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.brand.withOpacity(0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            const SizedBox(height: 8),

            // Top Row: Chuông thông báo - Logo - Nút Profile
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Nút thông báo
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none_rounded, color: Colors.white),
                      tooltip: 'Thông báo',
                      onPressed: () {
                        HapticFeedback.lightImpact();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Không có thông báo mới hôm nay!'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ),

                  // Tên app
                  Column(
                    children: [
                      Text(
                        'SyncFlow',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                          color: Colors.white,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Text(
                        'Nhịp học tập trung',
                        style: TextStyle(
                          fontFamily: AppFonts.poppins,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),

                  // NÚT PROFILE GÓC TRÊN BÊN PHẢI (như trong ảnh mẫu)
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.lightImpact();
                      context.push(RouteConstants.profile);
                    },
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white.withOpacity(0.8), width: 2),
                        color: Colors.white.withOpacity(0.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.12),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: user?.avatar != null && user!.avatar!.isNotEmpty
                            ? Image.network(
                                user.avatar!,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) => _buildProfileFallback(initial),
                              )
                            : _buildProfileFallback(initial),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Lời chào cá nhân
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${_getGreeting()}, $userName 👋',
                          style: const TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dueCount > 0
                              ? 'Bạn có $dueCount từ cần ôn lại hôm nay để giữ nhịp Flow!'
                              : 'Tuyệt vời! Bạn đã hoàn thành các thẻ đến hạn.',
                          style: TextStyle(
                            fontFamily: AppFonts.poppins,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.85),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Hero Carousel Cards
            CarouselSlider(
              options: CarouselOptions(
                height: 140,
                viewportFraction: 0.9,
                enlargeCenterPage: true,
                enlargeFactor: 0.18,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 6),
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentSlide = index;
                  });
                },
              ),
              items: [
                // Slide 1: SRS Flow Focus
                _buildCarouselCard(
                  context,
                  badge: 'HÀNG ĐỢI ÔN TẬP',
                  badgeColor: colors.amber,
                  title: dueCount > 0
                      ? '$dueCount thẻ đến hạn nạp lại'
                      : 'Kho từ đã được đồng bộ',
                  subtitle: leechCount > 0
                      ? 'Có $leechCount từ hay quên cần giải cứu'
                      : 'Trí nhớ đang ở trạng thái tối ưu',
                  actionLabel: dueCount > 0 ? 'Ôn tập ngay' : 'Khám phá thêm',
                  actionIcon: Icons.bolt_rounded,
                  onAction: widget.onStartDueStudy,
                ),

                // Slide 2: Streak & Level
                _buildCarouselCard(
                  context,
                  badge: 'TIẾN TRÌNH CÁ NHÂN',
                  badgeColor: colors.mint,
                  title: 'Chuỗi Streak ${progression.streak} ngày',
                  subtitle: '${progression.rankTitle} • ${progression.totalExp} EXP',
                  actionLabel: 'Xem bảng xếp hạng',
                  actionIcon: Icons.leaderboard_rounded,
                  onAction: () {
                    // Navigate or invoke
                  },
                ),

                // Slide 3: Flow Focus Advice
                _buildCarouselCard(
                  context,
                  badge: 'TRẠNG THÁI FLOW',
                  badgeColor: const Color(0xFF38BDF8),
                  title: '15 phút mỗi ngày',
                  subtitle: 'Học ngắt quãng giúp khắc sâu từ vựng gấp 3 lần',
                  actionLabel: 'Bắt đầu phiên học',
                  actionIcon: Icons.play_arrow_rounded,
                  onAction: widget.onStartDueStudy,
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Carousel Dots Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = _currentSlide == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: isActive ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(3),
                  ),
                );
              }),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileFallback(String initial) {
    return Container(
      color: Colors.white.withOpacity(0.25),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: const TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w800,
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _buildCarouselCard(
    BuildContext context, {
    required String badge,
    required Color badgeColor,
    required String title,
    required String subtitle,
    required String actionLabel,
    required IconData actionIcon,
    required VoidCallback onAction,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  badge,
                  style: TextStyle(
                    fontFamily: AppFonts.poppins,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              Icon(actionIcon, color: Colors.white.withOpacity(0.9), size: 18),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: AppFonts.poppins,
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.white.withOpacity(0.85),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: onAction,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      actionLabel,
                      style: TextStyle(
                        fontFamily: AppFonts.poppins,
                        fontWeight: FontWeight.w800,
                        fontSize: 11,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 13,
                      color: Theme.of(context).primaryColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
