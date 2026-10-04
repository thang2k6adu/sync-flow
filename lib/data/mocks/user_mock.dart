import 'package:pp191225/data/mocks/mock_api_response.dart';

/// Mock data cho /users/*. State giữ trong bộ nhớ nên updateProfile có hiệu lực ngay.
class UserMock {
  UserMock._();

  static const defaultEmail = 'dev@example.com';

  static Map<String, dynamic> _current = _build(defaultEmail);

  static Map<String, dynamic> _build(String email, {String? name}) {
    final local = email.split('@').first;
    final display = local.isEmpty
        ? 'Dev'
        : '${local[0].toUpperCase()}${local.substring(1)}';
    return {
      'id': 'mock-user-1',
      'email': email,
      'name': name ?? display,
      'avatar': 'https://i.pravatar.cc/200?img=12',
      'role': 'user',
    };
  }

  /// Gọi khi login/register thành công: user hiện tại đổi theo email đăng nhập.
  static Map<String, dynamic> signIn(String email, {String? name}) {
    _current = _build(email, name: name);
    return _current;
  }

  static Map<String, dynamic> profile() => mockSuccess(data: _current);

  static Map<String, dynamic> updateProfile(Map<String, dynamic> body) {
    _current = {
      ..._current,
      if (body['name'] != null) 'name': body['name'],
      if (body['avatar'] != null) 'avatar': body['avatar'],
    };
    return mockSuccess(data: _current, message: 'Profile updated');
  }

  static Map<String, dynamic> getById(String id) {
    if (id == _current['id']) return mockSuccess(data: _current);
    return mockSuccess(
      data: {
        'id': id,
        'email': '$id@example.com',
        'name': 'User $id',
        'avatar': 'https://i.pravatar.cc/200?u=$id',
        'role': 'user',
      },
    );
  }
}
