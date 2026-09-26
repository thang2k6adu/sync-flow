import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';
import 'package:pp191225/domain/entities/auth/token.dart';
import 'package:pp191225/domain/failures/failures.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthResponse>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthResponse>> register({
    required String email,
    required String password,
    String? name,
  });

  Future<Either<Failure, AuthResponse>> loginWithFirebase({
    required String idToken,
    String? deviceId,
    String? platform,
  });

  Future<Either<Failure, Token>> refreshToken(String refreshToken);

  Future<Either<Failure, void>> logout();

  Future<Either<Failure, Token?>> getToken();

  Future<bool> isAuthenticated();

  Future<Either<Failure, void>> clearTokens();

  Future<Either<Failure, void>> saveTokens(Token token);
}
