import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/tasks/task.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';
import 'package:pp191225/domain/usecases/task/create_task_usecase.dart';

/// Update task use case (validates input before calling the repository)
class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<Either<Failure, Task>> call({
    required String id,
    String? title,
    String? description,
    TaskStatus? status,
    DateTime? dueDate,
  }) {
    if (title == null &&
        description == null &&
        status == null &&
        dueDate == null) {
      return Future.value(
        const Left(ValidationFailure(message: 'Nothing to update')),
      );
    }

    final cleanTitle = title?.trim();
    if (cleanTitle != null) {
      if (cleanTitle.isEmpty) {
        return Future.value(
          const Left(ValidationFailure(message: 'Title is required')),
        );
      }
      if (cleanTitle.length > CreateTaskUseCase.maxTitleLength) {
        return Future.value(
          const Left(
            ValidationFailure(
              message:
                  'Title must be at most ${CreateTaskUseCase.maxTitleLength} characters',
            ),
          ),
        );
      }
    }

    return repository.updateTask(
      id: id,
      title: cleanTitle,
      description: description?.trim(),
      status: status,
      dueDate: dueDate,
    );
  }
}
