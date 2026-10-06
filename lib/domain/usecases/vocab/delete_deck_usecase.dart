import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class DeleteDeckUseCase {
  final VocabRepository repository;

  DeleteDeckUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    if (id.trim().isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'ID bộ từ vựng không hợp lệ')),
      );
    }
    return repository.deleteDeck(id.trim());
  }
}
