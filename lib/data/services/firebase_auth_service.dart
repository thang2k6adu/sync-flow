import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:pp191225/core/core.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentFirebaseUser => _auth.currentUser;

  final GoogleSignIn _gsi = GoogleSignIn.instance;

  final String webClientId = ApiConstants.webClientId;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _gsi.initialize(clientId: kIsWeb ? null : webClientId);
    _initialized = true;
  }

  Future<String?> signInWithGoogle() async {
    await _ensureInitialized();
    try {
      if (!_gsi.supportsAuthenticate()) return null;
      // Isolate heavy logic to light isolate
      return await Future.microtask(() async {
        final GoogleSignInAccount account = await _gsi.authenticate();

        final googleAuth = account.authentication;
        final idToken = googleAuth.idToken;

        if (idToken == null) return null;

        final credential = GoogleAuthProvider.credential(idToken: idToken);
        final userCred = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );

        return await userCred.user?.getIdToken(true);
      });
    } on GoogleSignInException catch (e) {
      throw Exception('Google Sign-In failed: $e');
    } catch (e) {
      throw Exception('Unexpected Google Sign-In error: $e');
    }
  }

  Future<String> signInWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(email: username, password: password);

      final user = userCredential.user;
      if (user == null) {
        throw Exception('Không thể đăng nhập: Firebase user rỗng.');
      }
      // Lấy Firebase ID Token
      final idToken = await user.getIdToken(true);
      if (idToken == null) {
        throw Exception('Không thể đăng nhập: Firebase user rỗng.');
      }
      return idToken;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Không tìm thấy người dùng với email này.',
          );
        case 'wrong-password':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Sai mật khẩu. Vui lòng thử lại.',
          );
        case 'invalid-email':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Email không hợp lệ.',
          );
        case 'user-disabled':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Tài khoản này đã bị vô hiệu hóa.',
          );
        default:
          throw FirebaseAuthException(
            code: e.code,
            message: e.message ?? 'Đăng nhập thất bại, vui lòng thử lại.',
          );
      }
    } catch (e) {
      throw Exception('Lỗi không xác định khi đăng nhập: $e');
    }
  }

  /// Sign out from Firebase and Google
  Future<void> signOut() async {
    try {
      // Sign out from Firebase
      await _auth.signOut();
      
      // Sign out from Google
      await _gsi.signOut();
    } catch (e) {
      throw Exception('Đăng xuất thất bại: $e');
    }
  }
}
