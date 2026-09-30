import 'package:firebase_auth/firebase_auth.dart';
import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

class LoginWithPasswordUseCase {
  final AuthRepository repository;
  final FirebaseAuthService firebaseAuthService;

  LoginWithPasswordUseCase({
    required this.repository,
    required this.firebaseAuthService,
  });

  Future<Either<Failure, AuthResponse>> call({
    required String email,
    required String password,
  }) async {
    try {
      final idToken = await firebaseAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await repository.loginWithFirebase(idToken: idToken);
    } on FirebaseAuthException catch (e) {
      return Left(
        AuthFailure(
          message: e.message ?? 'Đăng nhập thất bại, vui lòng thử lại.',
          code: e.code,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
