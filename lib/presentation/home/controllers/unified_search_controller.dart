import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'package:pp191225/presentation/vocab/controllers/deck_list_controller.dart';
import 'package:pp191225/providers/usecases_provider.dart';

enum SearchTabFilter { all, decks, cards }

class UnifiedSearchState {
  final String query;
  final SearchTabFilter tabFilter;
  final List<Deck> matchedDecks;
  final List<VocabCard> matchedCards;
  final bool isLoading;

  const UnifiedSearchState({
    this.query = '',
    this.tabFilter = SearchTabFilter.all,
    this.matchedDecks = const [],
    this.matchedCards = const [],
    this.isLoading = false,
  });

  bool get isSearching => query.trim().isNotEmpty;
  int get totalMatches => matchedDecks.length + matchedCards.length;

  UnifiedSearchState copyWith({
    String? query,
    SearchTabFilter? tabFilter,
    List<Deck>? matchedDecks,
    List<VocabCard>? matchedCards,
    bool? isLoading,
  }) {
    return UnifiedSearchState(
      query: query ?? this.query,
      tabFilter: tabFilter ?? this.tabFilter,
      matchedDecks: matchedDecks ?? this.matchedDecks,
      matchedCards: matchedCards ?? this.matchedCards,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

final unifiedSearchControllerProvider =
    NotifierProvider<UnifiedSearchController, UnifiedSearchState>(
  UnifiedSearchController.new,
);

class UnifiedSearchController extends Notifier<UnifiedSearchState> {
  List<VocabCard> _allCachedCards = [];

  @override
  UnifiedSearchState build() {
    _loadAllCards();
    return const UnifiedSearchState();
  }

  Future<void> _loadAllCards() async {
    try {
      final getCards = ref.read(getCardsByDeckUseCaseProvider);
      final result = await getCards('');
      result.fold(
        (_) => null,
        (cards) => _allCachedCards = cards,
      );
    } catch (_) {}
  }

  void setTabFilter(SearchTabFilter filter) {
    state = state.copyWith(tabFilter: filter);
  }

  void onQueryChanged(String query) {
    final clean = query.trim().toLowerCase();
    if (clean.isEmpty) {
      state = state.copyWith(
        query: '',
        matchedDecks: [],
        matchedCards: [],
        isLoading: false,
      );
      return;
    }

    final allDecks = ref.read(deckListControllerProvider).value ?? [];

    // Lọc bộ từ
    final matchedDecks = allDecks.where((d) {
      final nameMatch = d.name.toLowerCase().contains(clean);
      final descMatch = d.description?.toLowerCase().contains(clean) ?? false;
      final catMatch = d.category?.toLowerCase().contains(clean) ?? false;
      final cefrMatch = d.cefrLevel?.toLowerCase().contains(clean) ?? false;
      return nameMatch || descMatch || catMatch || cefrMatch;
    }).toList();

    // Lọc thẻ từ vựng
    final matchedCards = _allCachedCards.where((c) {
      final termMatch = c.term.toLowerCase().contains(clean);
      final phoneticMatch = c.phonetic?.toLowerCase().contains(clean) ?? false;
      final meaningMatch = c.meanings.any((m) =>
          m.meaningVi.toLowerCase().contains(clean) ||
          (m.definitionEn?.toLowerCase().contains(clean) ?? false));
      final collocMatch = c.collocations.any((col) => col.toLowerCase().contains(clean));
      return termMatch || phoneticMatch || meaningMatch || collocMatch;
    }).toList();

    state = state.copyWith(
      query: query,
      matchedDecks: matchedDecks,
      matchedCards: matchedCards,
      isLoading: false,
    );
  }

  void clearSearch() {
    state = state.copyWith(
      query: '',
      matchedDecks: [],
      matchedCards: [],
      isLoading: false,
    );
  }
}
