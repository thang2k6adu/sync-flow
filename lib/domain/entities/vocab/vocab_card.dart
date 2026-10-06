import 'meaning.dart';
import 'card_exercise.dart';

class VocabCard {
  final String id;
  final String deckId;
  final String term;
  final String? phonetic;
  final String? audioUrl;
  final String? cefrLevel;
  final int? frequencyRank;
  final String? wordFamilyId;
  final List<String> tagIds;
  final List<Meaning> meanings;
  final List<String> collocations;
  final List<CardExercise> exercises;

  const VocabCard({
    required this.id,
    required this.deckId,
    required this.term,
    this.phonetic,
    this.audioUrl,
    this.cefrLevel,
    this.frequencyRank,
    this.wordFamilyId,
    this.tagIds = const [],
    this.meanings = const [],
    this.collocations = const [],
    this.exercises = const [],
  });
}
