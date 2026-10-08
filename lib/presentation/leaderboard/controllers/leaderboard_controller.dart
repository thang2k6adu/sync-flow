import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/presentation/auth/controllers/auth_controller.dart';
import 'package:pp191225/presentation/leaderboard/models/leaderboard_entry.dart';
import 'package:pp191225/presentation/progression/controllers/progression_controller.dart';

class LeaderboardState {
  final List<LeaderboardEntry> topThree;
  final LeaderboardEntry myStanding;
  final List<LeaderboardEntry> restList;

  const LeaderboardState({
    required this.topThree,
    required this.myStanding,
    required this.restList,
  });
}

final leaderboardControllerProvider = Provider<LeaderboardState>((ref) {
  final user = ref.watch(authControllerProvider);
  final progState = ref.watch(progressionControllerProvider);
  final progression = progState.progression;

  final userName = (user != null && user.name.isNotEmpty) ? user.name : 'Bạn (Tập Sự)';
  final userExp = progression.totalExp > 0 ? progression.totalExp : 420;

  // Dữ liệu mẫu thực tế của cộng đồng học viên
  final List<LeaderboardEntry> allMembers = [
    const LeaderboardEntry(
      rank: 1,
      id: 'user-1',
      name: 'Minh Khang',
      avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?w=150',
      exp: 3850,
      masteredWords: 420,
      streak: 45,
      rankTitle: 'Bậc Thầy (Master)',
      rankDiff: 0,
    ),
    const LeaderboardEntry(
      rank: 2,
      id: 'user-2',
      name: 'Thu Hà',
      avatar: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
      exp: 2940,
      masteredWords: 310,
      streak: 28,
      rankTitle: 'Học Giả (Expert)',
      rankDiff: 1,
    ),
    const LeaderboardEntry(
      rank: 3,
      id: 'user-3',
      name: 'Gia Bảo',
      avatar: 'https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?w=150',
      exp: 2150,
      masteredWords: 240,
      streak: 19,
      rankTitle: 'Chuyên Cần (Scholar)',
      rankDiff: -1,
    ),
    LeaderboardEntry(
      rank: 4,
      id: 'current-user',
      name: userName,
      avatar: user?.avatar,
      exp: userExp,
      masteredWords: progression.wordsMastered > 0 ? progression.wordsMastered : 65,
      streak: progression.streak > 0 ? progression.streak : 5,
      rankTitle: progression.rankTitle,
      rankDiff: 12, // Tăng trưởng 12 bậc
      isCurrentUser: true,
    ),
    const LeaderboardEntry(
      rank: 5,
      id: 'user-4',
      name: 'Phương Linh',
      avatar: 'https://images.unsplash.com/photo-1580489944761-15a19d654956?w=150',
      exp: 1380,
      masteredWords: 155,
      streak: 14,
      rankTitle: 'Tinh Anh (Apprentice)',
      rankDiff: 3,
    ),
    const LeaderboardEntry(
      rank: 6,
      id: 'user-5',
      name: 'Hoàng Long',
      avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      exp: 990,
      masteredWords: 110,
      streak: 9,
      rankTitle: 'Tinh Anh (Apprentice)',
      rankDiff: -2,
    ),
    const LeaderboardEntry(
      rank: 7,
      id: 'user-6',
      name: 'Thảo My',
      avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
      exp: 720,
      masteredWords: 85,
      streak: 7,
      rankTitle: 'Khám Phá (Explorer)',
      rankDiff: 4,
    ),
    const LeaderboardEntry(
      rank: 8,
      id: 'user-7',
      name: 'Quốc Đạt',
      avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=150',
      exp: 510,
      masteredWords: 52,
      streak: 4,
      rankTitle: 'Khám Phá (Explorer)',
      rankDiff: 1,
    ),
  ];

  final topThree = allMembers.sublist(0, 3);
  final myStanding = allMembers.firstWhere((e) => e.isCurrentUser);
  final restList = allMembers.sublist(3);

  return LeaderboardState(
    topThree: topThree,
    myStanding: myStanding,
    restList: restList,
  );
});
