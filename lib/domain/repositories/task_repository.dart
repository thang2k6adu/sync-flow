import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/pagination/paginated_result.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/failures/failures.dart';

/// Task repository interface
/// Defines the contract for task operations
/// This is implemented in the data layer
abstract class TaskRepository {
  /// Get a page of tasks of the current user
  Future<Either<Failure, PaginatedResult<Task>>> getTasks({
    required int page,
    required int limit,
    String? search,
    TaskStatus? status,
  });

  /// Create a new task
  Future<Either<Failure, Task>> createTask({
    required String title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  });

  /// Update a task (null fields are left unchanged)
  Future<Either<Failure, Task>> updateTask({
    required String id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  });

  /// Delete a task
  Future<Either<Failure, void>> deleteTask(String id);
}
