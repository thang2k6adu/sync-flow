import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/vocab_card.dart';
import 'meaning_dto.dart';
import 'card_exercise_dto.dart';

part 'card_dto.freezed.dart';
part 'card_dto.g.dart';

@freezed
abstract class CardDto with _$CardDto {
  const CardDto._();

  const factory CardDto({
    required String id,
    required String deckId,
    required String term,
    String? phonetic,
    String? audioUrl,
    String? cefrLevel,
    int? frequencyRank,
    String? wordFamilyId,
    @Default([]) List<String> tagIds,
    @Default([]) List<MeaningDto> meanings,
    @Default([]) List<String> collocations,
    @Default([]) List<CardExerciseDto> exercises,
  }) = _CardDto;

  factory CardDto.fromJson(Map<String, dynamic> json) =>
      _$CardDtoFromJson(json);

  VocabCard toEntity() {
    return VocabCard(
      id: id,
      deckId: deckId,
      term: term,
      phonetic: phonetic,
      audioUrl: audioUrl,
      cefrLevel: cefrLevel,
      frequencyRank: frequencyRank,
      wordFamilyId: wordFamilyId,
      tagIds: tagIds,
      meanings: meanings.map((m) => m.toEntity()).toList(),
      collocations: collocations,
      exercises: exercises.map((e) => e.toEntity()).toList(),
    );
  }
}
