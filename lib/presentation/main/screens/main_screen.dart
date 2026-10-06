import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/presentation/profile/screens/profile_screen.dart';
import 'package:pp191225/presentation/settings/screens/settings_screen.dart';
import 'package:pp191225/presentation/vocab/screens/deck_list_screen.dart';
import 'package:pp191225/shared/widgets/common/chunky_card.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  int selectedIndex = 0;

  void touchBottomNavBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      const DeckListScreen(),
      const ProfileScreen(),
      const SettingsScreen(),
    ];

    return Scaffold(
      body: children[selectedIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: ChunkyColors.border, width: 2)),
        ),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: touchBottomNavBar,
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: ChunkyColors.brand,
          unselectedItemColor: const Color(0xFFAFAFAF),
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book_rounded),
              label: "Từ vựng",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_rounded),
              label: "Hồ sơ",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_rounded),
              label: "Cài đặt",
            ),
          ],
        ),
      ),
    );
  }
}
