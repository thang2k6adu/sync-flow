import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/auth/token.dart';

part 'token_dto.freezed.dart';
part 'token_dto.g.dart';

/// Token Data Transfer Object
/// Used for JSON serialization/deserialization
@freezed
abstract class TokenDto with _$TokenDto {
  const TokenDto._();

  const factory TokenDto({
    @JsonKey(name: 'accessToken') required String accessToken,
    @JsonKey(name: 'refreshToken') String? refreshToken,
    @JsonKey(name: 'expiresIn') int? expiresIn, // seconds
  }) = _TokenDto;

  factory TokenDto.fromJson(Map<String, Object?> json) =>
      _$TokenDtoFromJson(json);

  factory TokenDto.empty() =>
      const TokenDto(accessToken: '', refreshToken: '', expiresIn: null);

  /// Convert DTO to Domain Entity
  Token toEntity() {
    return Token(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}

/// Extension to convert Domain Entity to DTO
extension TokenToDto on Token {
  TokenDto toDto() {
    return TokenDto(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresIn: expiresIn,
    );
  }
}
