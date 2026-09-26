import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/datasources/remote/task_remote_datasource.dart';
import 'package:pp191225/domain/entities/pagination/paginated_result.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';

/// Implementation of TaskRepository
class TaskRepositoryImpl implements TaskRepository {
  final TaskRemoteDataSource remoteDataSource;

  TaskRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, PaginatedResult<Task>>> getTasks({
    required int page,
    required int limit,
    String? search,
    TaskStatus? status,
  }) async {
    try {
      final res = await remoteDataSource.getTasks(
        page: page,
        limit: limit,
        search: search,
        status: status?.value,
      );
      if (res.error || res.data == null) {
        return Left(
          ServerFailure(message: res.message, code: res.code.toString()),
        );
      }

      final data = res.data!;
      return Right(
        PaginatedResult<Task>(
          items: data.items.map((dto) => dto.toEntity()).toList(),
          meta: data.meta,
        ),
      );
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Task>> createTask({
    required String title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) async {
    try {
      final res = await remoteDataSource.createTask(
        title: title,
        description: description,
        status: status?.value,
        dueDate: dueDate,
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
  Future<Either<Failure, Task>> updateTask({
    required String id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) async {
    try {
      final res = await remoteDataSource.updateTask(
        id: id,
        title: title,
        description: description,
        status: status?.value,
        dueDate: dueDate,
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
  Future<Either<Failure, void>> deleteTask(String id) async {
    try {
      final res = await remoteDataSource.deleteTask(id);
      if (res.error) {
        return Left(
          ServerFailure(message: res.message, code: res.code.toString()),
        );
      }

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
