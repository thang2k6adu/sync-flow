import 'package:firebase_auth/firebase_auth.dart';
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
        return const Left(AuthFailure(message: 'Provider sign in failed'));
      }

      final authResult = await repository.loginWithFirebase(idToken: idToken);

      return await authResult.fold((failure) => Left(failure), (
        authResponse,
      ) async {
        await repository.saveTokens(authResponse.tokens);
        return Right(authResponse);
      });
    } on GoogleAccountLinkRequiredException catch (e) {
      return Left(
        AuthFailure(message: 'Email này đã đăng ký bằng password.', details: e),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<Either<Failure, AuthResponse>> linkGoogleWithPassword({
    required String email,
    required String password,
    required AuthCredential googleCredential,
  }) async {
    try {
      final idToken = await firebaseAuthService.linkGoogleWithEmailPassword(
        email: email,
        password: password,
        googleCredential: googleCredential,
      );
      final authResult = await repository.loginWithFirebase(idToken: idToken);

      return await authResult.fold((failure) => Left(failure), (
        authResponse,
      ) async {
        await repository.saveTokens(authResponse.tokens);
        return Right(authResponse);
      });
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
