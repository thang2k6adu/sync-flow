import 'package:pp191225/core/constants/app_constants.dart';
import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/datasources/local/auth_local_datasource.dart';
import 'package:pp191225/data/datasources/remote/auth_remote_datasource.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';
import 'package:pp191225/domain/entities/auth/token.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, AuthResponse>> register({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      final res = await remoteDataSource.register(
        email: email,
        password: password,
        name: name,
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }

      final auth = res.data!.toEntity();
      await localDataSource.saveToken(auth.tokens.toDto());
      return Right(auth);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> loginWithFirebase({
    required String idToken,
    String? deviceId,
    String? platform,
  }) async {
    try {
      final res = await remoteDataSource.loginWithFirebase(
        idToken: idToken,
        deviceId: deviceId ?? AppConstants.deviceId,
        platform: platform ?? AppConstants.osType?.toLowerCase(),
      );
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }

      final auth = res.data!.toEntity();
      await localDataSource.saveToken(auth.tokens.toDto());
      return Right(auth);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token>> refreshToken(String refreshToken) async {
    try {
      final res = await remoteDataSource.refreshToken(refreshToken);
      if (res.error || res.data == null) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }

      final token = res.data!.toEntity();
      await localDataSource.saveToken(token.toDto());
      return Right(token);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      final res = await remoteDataSource.logout();
      if (res.error) {
        return Left(ServerFailure(message: res.message, code: res.code.toString()));
      }
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Token?>> getToken() async {
    try {
      final tokenDto = await localDataSource.getToken();
      if (tokenDto == null) {
        return const Right(null);
      }
      return Right(tokenDto.toEntity());
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    try {
      return await localDataSource.isAuthenticated();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, void>> clearTokens() async {
    try {
      await localDataSource.clearTokens();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, void>> saveTokens(Token token) async {
    try {
      final tokenDto = token.toDto();
      await localDataSource.saveToken(tokenDto);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
