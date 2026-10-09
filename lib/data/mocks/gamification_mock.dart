import 'package:pp191225/data/mocks/mock_api_response.dart';

/// Mock cho gamification khi USE_MOCK_DATA=true (dev UI offline).
/// Response dựng y hệt backend thật: GET /users/progression,
/// POST /users/progression/add, GET /users/leaderboard.
/// Đây là mock hạ tầng cho dev, KHÔNG phải dữ liệu giả hard-code trong UI:
/// màn hình leaderboard/progression luôn đi qua ApiService -> repository.
class GamificationMock {
  GamificationMock._();

  static int _totalExp = 420;
  static int _currentExp = 20;
  static int _level = 3;
  static int _streak = 5;
  static int _wordsMastered = 65;
  static int _totalReviews = 120;

  static String _rankTitle(int level) {
    if (level <= 1) return 'Tập Sự (Novice)';
    if (level == 2) return 'Khám Phá (Explorer)';
    if (level == 3) return 'Tinh Anh (Apprentice)';
    if (level == 4) return 'Chuyên Cần (Scholar)';
    if (level == 5) return 'Học Giả (Expert)';
    return 'Bậc Thầy (Master)';
  }

  static Map<String, dynamic> _progressionData() {
    return {
      'level': _level,
      'currentExp': _currentExp,
      'totalExp': _totalExp,
      'expToNextLevel': _level * 100,
      'streak': _streak,
      'wordsMastered': _wordsMastered,
      'totalReviews': _totalReviews,
      'rankTitle': _rankTitle(_level),
      'lastStudyDate': DateTime.now().toUtc().toIso8601String(),
    };
  }

  static Map<String, dynamic> progression() => mockSuccess(data: _progressionData());

  static Map<String, dynamic> addProgression(Map<String, dynamic> body) {
    final gained = mockToInt(body['expGained'], 0);
    if (gained > 0) {
      _totalExp += gained;
      _currentExp += gained;
      while (_currentExp >= _level * 100) {
        _currentExp -= _level * 100;
        _level += 1;
      }
    }
    if (body['cardStudied'] == true || body['correctExercise'] == true) {
      _totalReviews += 1;
    }
    if (body['wordMastered'] == true) _wordsMastered += 1;
    return mockSuccess(data: _progressionData());
  }

  static Map<String, dynamic> leaderboard(Map<String, dynamic> query) {
    final limit = mockToInt(query['limit'], 20);
    final me = {
      'rank': 4,
      'id': 'mock-user-1',
      'name': 'Bạn (Tập Sự)',
      'avatar': 'https://i.pravatar.cc/200?img=12',
      'exp': _totalExp,
      'masteredWords': _wordsMastered,
      'streak': _streak,
      'rankTitle': _rankTitle(_level),
      'isCurrentUser': true,
    };
    final others = [
      {
        'rank': 1,
        'id': 'mock-lb-1',
        'name': 'Minh Khang',
        'avatar': 'https://i.pravatar.cc/200?img=11',
        'exp': 3850,
        'masteredWords': 420,
        'streak': 45,
        'rankTitle': 'Bậc Thầy (Master)',
        'isCurrentUser': false,
      },
      {
        'rank': 2,
        'id': 'mock-lb-2',
        'name': 'Thu Hà',
        'avatar': 'https://i.pravatar.cc/200?img=32',
        'exp': 2940,
        'masteredWords': 310,
        'streak': 28,
        'rankTitle': 'Học Giả (Expert)',
        'isCurrentUser': false,
      },
      {
        'rank': 3,
        'id': 'mock-lb-3',
        'name': 'Gia Bảo',
        'avatar': 'https://i.pravatar.cc/200?img=13',
        'exp': 2150,
        'masteredWords': 240,
        'streak': 19,
        'rankTitle': 'Chuyên Cần (Scholar)',
        'isCurrentUser': false,
      },
      me,
      {
        'rank': 5,
        'id': 'mock-lb-4',
        'name': 'Phương Linh',
        'avatar': 'https://i.pravatar.cc/200?img=47',
        'exp': 1380,
        'masteredWords': 155,
        'streak': 14,
        'rankTitle': 'Tinh Anh (Apprentice)',
        'isCurrentUser': false,
      },
    ];
    final all = others.take(limit <= 0 ? 20 : limit).toList();
    final topThree = all.take(3).toList();
    final rest = all.where((e) => (e['rank'] as int) > 3).toList();
    return mockSuccess(data: {
      'topThree': topThree,
      'myStanding': me,
      'restList': rest,
      'totalMembers': all.length,
    });
  }
}
