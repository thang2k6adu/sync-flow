import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/data/models/auth/token_dto.dart';
import 'package:pp191225/data/models/users/user_dto.dart';
import 'package:pp191225/domain/entities/auth/auth_response.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

/// Auth Response Data Transfer Object
/// Used for JSON serialization/deserialization in login/register operations
@freezed
abstract class AuthResponseDto with _$AuthResponseDto {
  const AuthResponseDto._();

  const factory AuthResponseDto({
    required UserDto user,
    required TokenDto tokens,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, Object?> json) =>
      _$AuthResponseDtoFromJson(json);

  /// Convert DTO to Domain Entity
  AuthResponse toEntity() {
    return AuthResponse(
      user: user.toEntity(),
      tokens: tokens.toEntity(),
    );
  }
}

/// Extension to convert Domain Entity to DTO
extension AuthResponseToDto on AuthResponse {
  AuthResponseDto toDto() {
    return AuthResponseDto(
      user: user.toDto(),
      tokens: tokens.toDto(),
    );
  }
}
