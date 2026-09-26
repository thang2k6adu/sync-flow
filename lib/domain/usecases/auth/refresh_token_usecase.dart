import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/auth/token.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository repository;

  RefreshTokenUseCase(this.repository);

  Future<Either<Failure, Token>> call() async {
    try {
      final tokenResult = await repository.getToken();
      
      return tokenResult.fold(
        (failure) => Left(failure),
        (token) async {
          if (token == null || token.refreshToken == null || token.refreshToken!.isEmpty) {
            await repository.clearTokens();
            return const Left(AuthFailure(message: 'No refresh token available'));
          }

          final refreshResult = await repository.refreshToken(token.refreshToken!);
          
          return refreshResult.fold(
            (failure) async {
              await repository.clearTokens();
              return Left(failure);
            },
            (newToken) async {
              await repository.saveTokens(newToken);
              return Right(newToken);
            },
          );
        },
      );
    } catch (e) {
      await repository.clearTokens();
      return Left(AuthFailure(message: e.toString()));
    }
  }
}
