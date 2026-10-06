import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class GetDecksUseCase {
  final VocabRepository repository;

  GetDecksUseCase(this.repository);

  Future<Either<Failure, List<Deck>>> call() {
    return repository.getDecks();
  }
}
