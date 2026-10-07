import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/core/base/base_async_notifier.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/usecases/vocab/create_deck_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/delete_deck_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/get_decks_usecase.dart';
import 'package:pp191225/domain/usecases/vocab/get_study_queue_usecase.dart';
import 'package:pp191225/providers/usecases_provider.dart';

final deckListControllerProvider =
    AsyncNotifierProvider<DeckListController, List<Deck>>(
  DeckListController.new,
);

/// Lấy số lượng Leech Card để hiển thị lên Banner cứu trợ
final leechCountProvider = FutureProvider.autoDispose<int>((ref) async {
  final getQueue = ref.read(getStudyQueueUseCaseProvider);
  final result = await getQueue(limit: 100);
  return result.fold(
    (l) => 0,
    (queue) => queue.where((item) => item.isLeech).length,
  );
});

class DeckListController extends BaseAsyncNotifier<List<Deck>> {
  late GetDecksUseCase _getDecks;
  late CreateDeckUseCase _createDeck;
  late DeleteDeckUseCase _deleteDeck;

  @override
  Future<List<Deck>> build() {
    _getDecks = ref.read(getDecksUseCaseProvider);
    _createDeck = ref.read(createDeckUseCaseProvider);
    _deleteDeck = ref.read(deleteDeckUseCaseProvider);
    return super.build();
  }

  @override
  Future<List<Deck>> fetchData() async {
    final result = await _getDecks();
    return result.fold(
      (failure) => throw Exception(failure.message),
      (decks) => decks,
    );
  }

  Future<Deck?> createDeck({
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
  }) async {
    final result = await _createDeck(
      name: name,
      description: description,
      category: category,
      iconUrl: iconUrl,
      cefrLevel: cefrLevel,
    );

    return result.fold(
      (failure) => throw Exception(failure.message),
      (newDeck) {
        state.whenData((currentList) {
          state = AsyncData([newDeck, ...currentList]);
        });
        return newDeck;
      },
    );
  }

  Future<void> deleteDeck(String id) async {
    final result = await _deleteDeck(id);
    result.fold(
      (failure) => throw Exception(failure.message),
      (_) {
        state.whenData((currentList) {
          state = AsyncData(currentList.where((d) => d.id != id).toList());
        });
      },
    );
  }
}
