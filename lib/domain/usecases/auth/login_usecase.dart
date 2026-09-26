import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, AuthResponse>> call({
    required String email,
    required String password,
  }) async {
    final result = await repository.login(email: email, password: password);
    
    return result.fold(
      (failure) => Left(failure),
      (authResponse) async {
        await repository.saveTokens(authResponse.tokens);
        return Right(authResponse);
      },
    );
  }
}
