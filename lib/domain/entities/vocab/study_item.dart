import 'meaning.dart';
import 'card_exercise.dart';

class StudyItem {
  final String cardId;
  final String term;
  final String? phonetic;
  final String? audioUrl;
  final int masteryLevel;
  final String state;
  final int lapsesCount;
  final bool isLeech;
  final List<Meaning> meanings;
  final CardExercise? currentExercise;

  const StudyItem({
    required this.cardId,
    required this.term,
    this.phonetic,
    this.audioUrl,
    this.masteryLevel = 0,
    this.state = 'NEW',
    this.lapsesCount = 0,
    this.isLeech = false,
    this.meanings = const [],
    this.currentExercise,
  });
}
