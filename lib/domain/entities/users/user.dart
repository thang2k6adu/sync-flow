/// User entity - Pure Dart class without JSON serialization
/// This represents the business object in the domain layer
class User {
  final String id;
  final String email;
  final String name;
  final String? avatar;
  final String role;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.avatar,
    this.role = 'user',
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.avatar == avatar &&
        other.role == role;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        avatar.hashCode ^
        role.hashCode;
  }

  User copyWith({
    String? id,
    String? email,
    String? name,
    String? avatar,
    String? role,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      role: role ?? this.role,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, name: $name, avatar: $avatar, role: $role)';
  }
}
