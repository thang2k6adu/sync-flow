import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class CreateDeckUseCase {
  static const int maxNameLength = 100;
  final VocabRepository repository;

  CreateDeckUseCase(this.repository);

  Future<Either<Failure, Deck>> call({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  }) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) {
      return Future.value(
        const Left(ValidationFailure(message: 'Tên bộ từ vựng không được để trống')),
      );
    }
    if (cleanName.length > maxNameLength) {
      return Future.value(
        const Left(ValidationFailure(message: 'Tên bộ từ không được vượt quá $maxNameLength ký tự')),
      );
    }

    return repository.createDeck(
      name: cleanName,
      description: description?.trim().isEmpty == true ? null : description?.trim(),
      category: category?.trim().isEmpty == true ? null : category?.trim(),
      iconUrl: iconUrl?.trim().isEmpty == true ? null : iconUrl?.trim(),
      cefrLevel: cefrLevel?.trim().isEmpty == true ? null : cefrLevel?.trim(),
    );
  }
}
