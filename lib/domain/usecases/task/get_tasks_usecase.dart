import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/pagination/paginated_result.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';

/// Get tasks (paginated, optional search / status filter) use case
class GetTasksUseCase {
  static const int maxLimit = 100;

  final TaskRepository repository;

  GetTasksUseCase(this.repository);

  Future<Either<Failure, PaginatedResult<Task>>> call({
    int page = 1,
    int limit = 10,
    String? search,
    TaskStatus? status,
  }) {
    if (page < 1) {
      return Future.value(
        const Left(ValidationFailure(message: 'Page must be at least 1')),
      );
    }
    if (limit < 1 || limit > maxLimit) {
      return Future.value(
        const Left(
          ValidationFailure(message: 'Limit must be between 1 and $maxLimit'),
        ),
      );
    }

    final keyword = search?.trim();
    return repository.getTasks(
      page: page,
      limit: limit,
      search: (keyword == null || keyword.isEmpty) ? null : keyword,
      status: status,
    );
  }
}
