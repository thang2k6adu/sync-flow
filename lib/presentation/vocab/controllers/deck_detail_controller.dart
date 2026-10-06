import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/domain/usecases/vocab/create_card_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/get_cards_by_deck_usecase.dart';
import 'package:pp191225/providers/usecases_provider.dart';

final deckCardsControllerProvider =
    AutoDisposeAsyncNotifierProviderFamily<DeckCardsController, List<VocabCard>, String>(
  DeckCardsController.new,
);

class DeckCardsController extends AutoDisposeFamilyAsyncNotifier<List<VocabCard>, String> {
  late GetCardsByDeckUseCase _getCards;
  late CreateCardUseCase _createCard;

  @override
  Future<List<VocabCard>> build(String arg) async {
    _getCards = ref.read(getCardsByDeckUseCaseProvider);
    _createCard = ref.read(createCardUseCaseProvider);
    return _fetchCards(arg);
  }

  Future<List<VocabCard>> _fetchCards(String deckId) async {
    final result = await _getCards(deckId);
    return result.fold(
      (failure) => throw Exception(failure.message),
      (cards) => cards,
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final cards = await _fetchCards(arg);
      state = AsyncData(cards);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<VocabCard?> createCard({
    required String term,
    String? phonetic,
    String? audioUrl,
    String? cefrLevel,
    int? frequencyRank,
    String? wordFamilyId,
    List<String>? tagIds,
    List<Map<String, dynamic>>? meanings,
    List<String>? collocations,
    List<Map<String, dynamic>>? exercises,
  }) async {
    final result = await _createCard(
      deckId: arg,
      term: term,
      phonetic: phonetic,
      audioUrl: audioUrl,
      cefrLevel: cefrLevel,
      frequencyRank: frequencyRank,
      wordFamilyId: wordFamilyId,
      tagIds: tagIds,
      meanings: meanings,
      collocations: collocations,
      exercises: exercises,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (newCard) {
        state.whenData((currentList) {
          state = AsyncData([newCard, ...currentList]);
        });
        return newCard;
      },
    );
  }
}
