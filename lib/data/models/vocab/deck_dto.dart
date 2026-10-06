import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/deck.dart';

part 'deck_dto.freezed.dart';
part 'deck_dto.g.dart';

@freezed
abstract class DeckDto with _$DeckDto {
  const DeckDto._();

  const factory DeckDto({
    required String id,
    String? userId,
    required String name,
    String? description,
    String? category,
    String? iconUrl,
    String? cefrLevel,
    DateTime? createdAt,
  }) = _DeckDto;

  factory DeckDto.fromJson(Map<String, dynamic> json) =>
      _$DeckDtoFromJson(json);

  Deck toEntity() {
    return Deck(
      id: id,
      userId: userId,
      name: name,
      description: description,
      category: category,
      iconUrl: iconUrl,
      cefrLevel: cefrLevel,
      createdAt: createdAt?.toLocal(),
    );
  }
}
