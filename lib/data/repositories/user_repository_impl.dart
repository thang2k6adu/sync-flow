import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/datasources/remote/user_remote_datasource.dart';
import 'package:pp191225/domain/entities/users/user.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/user_repository.dart';

/// Implementation of UserRepository
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      final res = await remoteDataSource.getCurrentUser();
      if (res.error || res.data == null) {
        return Left(
          ServerFailure(message: res.message, code: res.code.toString()),
        );
      }

      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> updateProfile({
    String? name,
    String? avatar,
  }) async {
    try {
      final res = await remoteDataSource.updateProfile(
        name: name,
        avatar: avatar,
      );
      if (res.error || res.data == null) {
        return Left(
          ServerFailure(message: res.message, code: res.code.toString()),
        );
      }

      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    try {
      final res = await remoteDataSource.getUserById(userId);
      if (res.error || res.data == null) {
        return Left(
          ServerFailure(message: res.message, code: res.code.toString()),
        );
      }

      return Right(res.data!.toEntity());
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
