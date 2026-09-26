import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pp191225/domain/entities/users/user.dart';

part 'user_dto.freezed.dart';
part 'user_dto.g.dart';

/// User Data Transfer Object
/// Used for JSON serialization/deserialization
@freezed
abstract class UserDto with _$UserDto {
  const UserDto._();

  const factory UserDto({
    required String id,
    required String email,
    /// Backend (Nest/Java) trả firstName + lastName thay vì name
    String? name,
    String? firstName,
    String? lastName,
    String? avatar,
    @Default('user') String role,
  }) = _UserDto;

  factory UserDto.fromJson(Map<String, Object?> json) =>
      _$UserDtoFromJson(json);

  /// Convert DTO to Domain Entity
  User toEntity() {
    return User(
      id: id,
      email: email,
      name: displayName,
      avatar: avatar,
      role: role,
    );
  }

  /// Tên hiển thị: name nếu có, không thì ghép firstName + lastName, cuối cùng lấy email
  String get displayName {
    if (name != null && name!.trim().isNotEmpty) return name!.trim();
    final full = [firstName, lastName]
        .whereType<String>()
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .join(' ');
    return full.isNotEmpty ? full : email;
  }
}

/// Extension to convert Domain Entity to DTO
extension UserToDto on User {
  UserDto toDto() {
    return UserDto(
      id: id,
      email: email,
      name: name,
      avatar: avatar,
      role: role,
    );
  }
}
