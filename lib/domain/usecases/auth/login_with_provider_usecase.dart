import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

enum ProviderLogin { google, facebook, apple }

class LoginWithProviderUseCase {
  final AuthRepository repository;
  final FirebaseAuthService firebaseAuthService;

  LoginWithProviderUseCase({
    required this.repository,
    required this.firebaseAuthService,
  });

  Future<Either<Failure, AuthResponse>> call(ProviderLogin provider) async {
    try {
      final String? idToken;

      switch (provider) {
        case ProviderLogin.google:
          idToken = await firebaseAuthService.signInWithGoogle();
          break;
        case ProviderLogin.facebook:
          return const Left(
            ServerFailure(message: 'Facebook login not implemented yet'),
          );
        case ProviderLogin.apple:
          return const Left(
            ServerFailure(message: 'Apple login not implemented yet'),
          );
      }

      if (idToken == null || idToken.isEmpty) {
        return const Left(AuthFailure(message: 'Đăng nhập thất bại'));
      }

      return await repository.loginWithFirebase(idToken: idToken);
    } catch (e) {
      return const Left(ServerFailure(message: 'Đăng nhập thất bại'));
    }
  }
}
