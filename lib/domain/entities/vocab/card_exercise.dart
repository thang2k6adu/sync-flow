class CardExercise {
  final String? id;
  final String? cardId;
  final String exerciseType;
  final String? meaningHint;
  final String targetSentence;
  final String? vietnameseTranslation;
  final List<String> tokens;
  final List<String> distractorTokens;
  final int targetIndex;
  final String? audioUrl;

  const CardExercise({
    this.id,
    this.cardId,
    required this.exerciseType,
    this.meaningHint,
    required this.targetSentence,
    this.vietnameseTranslation,
    this.tokens = const [],
    this.distractorTokens = const [],
    this.targetIndex = 0,
    this.audioUrl,
  });
}
