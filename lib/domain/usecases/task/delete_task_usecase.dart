import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/task_repository.dart';

/// Delete task use case
class DeleteTaskUseCase {
  final TaskRepository repository;

  DeleteTaskUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    if (id.isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Task id is required')),
      );
    }
    return repository.deleteTask(id);
  }
}
