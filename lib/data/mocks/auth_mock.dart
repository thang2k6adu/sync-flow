import 'package:firebase_auth/firebase_auth.dart';
import 'package:pp191225/data/mocks/mock_api_response.dart';
import 'package:pp191225/data/mocks/user_mock.dart';

/// Mock data cho /auth/* và cho FirebaseAuthService khi USE_MOCK_DATA=true.
///
/// Đăng nhập chấp nhận mọi email/password, riêng [errorEmail] luôn thất bại
/// để test màn hình lỗi.
class AuthMock {
  AuthMock._();

  static const errorEmail = 'error@test.com';
  static const googleEmail = 'google.user@example.com';
  static const _idTokenPrefix = 'mock-firebase-id-token:';
  static const _latency = Duration(milliseconds: 300);

  static String idTokenFor(String email) => '$_idTokenPrefix$email';

  // ---- Thay thế FirebaseAuthService ----

  static Future<String> signInWithEmail(String email, String password) async {
    await Future<void>.delayed(_latency);
    final trimmed = email.trim();
    if (trimmed.toLowerCase() == errorEmail) {
      throw FirebaseAuthException(
        code: 'invalid-credential',
        message: 'Sai mật khẩu hoặc email. Vui lòng kiểm tra lại.',
      );
    }
    return idTokenFor(trimmed);
  }

  static Future<String> signInWithGoogle() async {
    await Future<void>.delayed(_latency);
    return idTokenFor(googleEmail);
  }

  static Future<void> createUser(String email) async {
    await Future<void>.delayed(_latency);
    if (email.trim().toLowerCase() == errorEmail) {
      throw FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'Email này đã được đăng ký.',
      );
    }
  }

  // ---- Response của /auth/* ----

  static Map<String, dynamic> _tokens() => {
    'accessToken': 'mock-access-token',
    'refreshToken': 'mock-refresh-token',
    'expiresIn': 3600,
  };

  static Map<String, dynamic> loginWithFirebase(Map<String, dynamic> body) {
    final idToken = '${body['idToken'] ?? ''}';
    final email = idToken.startsWith(_idTokenPrefix)
        ? idToken.substring(_idTokenPrefix.length)
        : UserMock.defaultEmail;
    final user = UserMock.signIn(email);
    return mockSuccess(data: {'user': user, 'tokens': _tokens()});
  }

  static Map<String, dynamic> register(Map<String, dynamic> body) {
    final name = [body['firstName'], body['lastName']]
        .whereType<String>()
        .where((s) => s.isNotEmpty)
        .join(' ');
    final user = UserMock.signIn(
      '${body['email'] ?? UserMock.defaultEmail}',
      name: name.isEmpty ? null : name,
    );
    return mockSuccess(
      data: {'user': user, 'tokens': _tokens()},
      code: 201,
      message: 'Registered',
    );
  }

  static Map<String, dynamic> refresh() => mockSuccess(data: _tokens());

  static Map<String, dynamic> logout() => mockSuccess(message: 'Logged out');
}
