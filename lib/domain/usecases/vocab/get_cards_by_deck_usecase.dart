import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/vocab_repository.dart';

class GetCardsByDeckUseCase {
  final VocabRepository repository;

  GetCardsByDeckUseCase(this.repository);

  Future<Either<Failure, List<VocabCard>>> call([String deckId = '']) {
    return repository.getCardsByDeck(deckId.trim());
  }
}
