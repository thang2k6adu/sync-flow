import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/vocab/meaning.dart';

part 'meaning_dto.freezed.dart';
part 'meaning_dto.g.dart';

@freezed
abstract class MeaningDto with _$MeaningDto {
  const MeaningDto._();

  const factory MeaningDto({
    @Default(0) int order,
    String? pos,
    @JsonKey(name: 'meaning_vi') required String meaningVi,
    @JsonKey(name: 'definition_en') String? definitionEn,
    @JsonKey(name: 'example_en') String? exampleEn,
    @JsonKey(name: 'example_vi') String? exampleVi,
  }) = _MeaningDto;

  factory MeaningDto.fromJson(Map<String, dynamic> json) =>
      _$MeaningDtoFromJson(json);

  Meaning toEntity() {
    return Meaning(
      order: order,
      pos: pos,
      meaningVi: meaningVi,
      definitionEn: definitionEn,
      exampleEn: exampleEn,
      exampleVi: exampleVi,
    );
  }
}
