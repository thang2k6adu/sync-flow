import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';

/// Create task use case (validates input before calling the repository)
class CreateTaskUseCase {
  static const int maxTitleLength = 200;

  final TaskRepository repository;

  CreateTaskUseCase(this.repository);

  Future<Either<Failure, Task>> call({
    required String title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) {
    final cleanTitle = title.trim();
    if (cleanTitle.isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Title is required')),
      );
    }
    if (cleanTitle.length > maxTitleLength) {
      return Future.value(
        const Left(
          ValidationFailure(
            message: 'Title must be at most $maxTitleLength characters',
          ),
        ),
      );
    }

    final cleanDescription = description?.trim();
    return repository.createTask(
      title: cleanTitle,
      description: (cleanDescription == null || cleanDescription.isEmpty)
          ? null
          : cleanDescription,
      status: status,
      dueDate: dueDate,
    );
  }
}
