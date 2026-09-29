import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pp191225/core/core.dart';

class GoogleAccountLinkRequiredException implements Exception {
  final String email;
  final AuthCredential credential;

  const GoogleAccountLinkRequiredException({
    required this.email,
    required this.credential,
  });
}

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? get currentFirebaseUser => _auth.currentUser;

  final GoogleSignIn _gsi = GoogleSignIn.instance;

  final String webClientId = ApiConstants.webClientId;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    await _gsi.initialize(
      clientId: kIsWeb ? webClientId : null,
      serverClientId: kIsWeb ? null : webClientId,
    );
    _initialized = true;
  }

  Future<String?> signInWithGoogle() async {
    await _ensureInitialized();
    AuthCredential? googleCredential;
    try {
      if (!_gsi.supportsAuthenticate()) return null;
      // Isolate heavy logic to light isolate
      return await Future.microtask(() async {
        final GoogleSignInAccount account = await _gsi.authenticate();

        final googleAuth = account.authentication;
        final idToken = googleAuth.idToken;

        if (idToken == null) return null;

        final credential = GoogleAuthProvider.credential(idToken: idToken);
        googleCredential = credential;
        final userCred = await FirebaseAuth.instance.signInWithCredential(
          credential,
        );

        return await userCred.user?.getIdToken(true);
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential' &&
          googleCredential != null &&
          e.email != null) {
        throw GoogleAccountLinkRequiredException(
          email: e.email!,
          credential: googleCredential!,
        );
      }
      throw Exception('Firebase Google Sign-In failed: ${e.message ?? e.code}');
    } on GoogleSignInException catch (e) {
      throw Exception('Google Sign-In failed: $e');
    } catch (e) {
      throw Exception('Unexpected Google Sign-In error: $e');
    }
  }

  Future<String> linkGoogleWithEmailPassword({
    required String email,
    required String password,
    required AuthCredential googleCredential,
  }) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Không thể liên kết: Firebase user rỗng.');
      }

      final linkedCredential = await user.linkWithCredential(googleCredential);
      final linkedUser = linkedCredential.user;
      final idToken = await linkedUser?.getIdToken(true);
      if (idToken == null) {
        throw Exception('Không thể lấy Firebase ID token.');
      }
      return idToken;
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(
        code: e.code,
        message: e.code == 'wrong-password'
            ? 'Sai mật khẩu email.'
            : e.message ?? 'Không thể liên kết Google với tài khoản này.',
      );
    }
  }

  Future<String> signInWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final UserCredential userCredential = await _auth
          .signInWithEmailAndPassword(
            email: username.trim(),
            password: password,
          );

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
        case 'invalid-credential':
        case 'invalid-login-credentials':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Sai mật khẩu hoặc email. Vui lòng kiểm tra lại.',
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
        case 'too-many-requests':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Bạn thử đăng nhập quá nhiều lần. Vui lòng thử lại sau.',
          );
        case 'network-request-failed':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Không có kết nối mạng. Vui lòng thử lại.',
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

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception('Không thể đăng ký: Firebase user rỗng.');
      }

      final trimmedName = displayName?.trim();
      if (trimmedName != null && trimmedName.isNotEmpty) {
        await user.updateDisplayName(trimmedName);
      }

      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Email này đã được đăng ký.',
          );
        case 'invalid-email':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Email không hợp lệ.',
          );
        case 'weak-password':
          throw FirebaseAuthException(
            code: e.code,
            message: 'Mật khẩu quá yếu. Vui lòng dùng ít nhất 6 ký tự.',
          );
        default:
          throw FirebaseAuthException(
            code: e.code,
            message: e.message ?? 'Đăng ký thất bại, vui lòng thử lại.',
          );
      }
    } catch (e) {
      throw Exception('Lỗi không xác định khi đăng ký: $e');
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
