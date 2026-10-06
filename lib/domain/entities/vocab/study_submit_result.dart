class StudySubmitResult {
  final String cardId;
  final String evaluatedRating;
  final int previousLevel;
  final int newLevel;
  final int previousInterval;
  final int newInterval;
  final double? easeFactor;
  final DateTime? dueDate;
  final bool isLeech;

  const StudySubmitResult({
    required this.cardId,
    required this.evaluatedRating,
    required this.previousLevel,
    required this.newLevel,
    required this.previousInterval,
    required this.newInterval,
    this.easeFactor,
    this.dueDate,
    this.isLeech = false,
  });
}
