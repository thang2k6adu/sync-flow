// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meaning_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MeaningDto _$MeaningDtoFromJson(Map<String, dynamic> json) => _MeaningDto(
  order: (json['order'] as num?)?.toInt() ?? 0,
  pos: json['pos'] as String?,
  meaningVi: json['meaning_vi'] as String,
  definitionEn: json['definition_en'] as String?,
  exampleEn: json['example_en'] as String?,
  exampleVi: json['example_vi'] as String?,
);

Map<String, dynamic> _$MeaningDtoToJson(_MeaningDto instance) =>
    <String, dynamic>{
      'order': instance.order,
      'pos': instance.pos,
      'meaning_vi': instance.meaningVi,
      'definition_en': instance.definitionEn,
      'example_en': instance.exampleEn,
      'example_vi': instance.exampleVi,
    };
