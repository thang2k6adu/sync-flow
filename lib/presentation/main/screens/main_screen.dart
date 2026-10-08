import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/theme/app_theme.dart';
import 'package:pp191225/presentation/home/screens/home_screen.dart';
import 'package:pp191225/presentation/leaderboard/screens/leaderboard_screen.dart';
import 'package:pp191225/presentation/main/widgets/collapsible_floating_nav_bar.dart';
import 'package:pp191225/presentation/settings/screens/settings_screen.dart';
import 'package:pp191225/presentation/vocab/screens/deck_list_screen.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int selectedIndex = 0;
  bool isNavCollapsed = false;

  void touchBottomNavBar(int index) {
    if (selectedIndex == index) return;
    HapticFeedback.selectionClick();
    setState(() {
      selectedIndex = index;
    });
  }

  void _expandNavBar() {
    if (!isNavCollapsed) return;
    setState(() {
      isNavCollapsed = false;
    });
  }

  void _collapseNavBar() {
    if (isNavCollapsed) return;
    setState(() {
      isNavCollapsed = true;
    });
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification) {
      if (notification.direction == ScrollDirection.reverse) {
        // Người dùng cuộn xuống để xem/thao tác nội dung -> Thu nhỏ navbar thành nút cạnh phải
        _collapseNavBar();
      } else if (notification.direction == ScrollDirection.forward) {
        // Người dùng cuộn lên -> Tự động bung mở thanh navbar
        _expandNavBar();
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.themeColors;

    final List<Widget> children = [
      HomeScreen(onSwitchTab: touchBottomNavBar),
      const DeckListScreen(),
      const LeaderboardScreen(),
      const SettingsScreen(),
    ];

    final navItems = const [
      CollapsibleNavItem(
        icon: Icons.school_outlined,
        activeIcon: Icons.school_rounded,
        label: 'Học tập',
      ),
      CollapsibleNavItem(
        icon: Icons.menu_book_outlined,
        activeIcon: Icons.menu_book_rounded,
        label: 'Kho từ',
      ),
      CollapsibleNavItem(
        icon: Icons.leaderboard_outlined,
        activeIcon: Icons.leaderboard_rounded,
        label: 'Xếp hạng',
      ),
      CollapsibleNavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        label: 'Cài đặt',
      ),
    ];

    return Scaffold(
      backgroundColor: colors.background,
      body: Stack(
        children: [
          // Nội dung trang bọc bởi NotificationListener để phát hiện cuộn/thao tác
          NotificationListener<ScrollNotification>(
            onNotification: _handleScrollNotification,
            child: IndexedStack(
              index: selectedIndex,
              children: children,
            ),
          ),

          // Thanh Navbar nổi có thể co lại thành nút hông (Dribbble Interaction)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CollapsibleFloatingNavBar(
              selectedIndex: selectedIndex,
              onItemSelected: touchBottomNavBar,
              items: navItems,
              isCollapsed: isNavCollapsed,
              onExpandRequest: _expandNavBar,
            ),
          ),
        ],
      ),
    );
  }
}
