/// Token entity - Pure Dart class without JSON serialization
/// This represents authentication tokens in the domain layer
class Token {
  final String accessToken;
  final String? refreshToken;
  final int? expiresIn; // seconds

  const Token({
    required this.accessToken,
    this.refreshToken,
    this.expiresIn,
  });

  factory Token.empty() => const Token(
        accessToken: '',
        refreshToken: '',
        expiresIn: null,
      );

  bool get isEmpty => accessToken.isEmpty;
  bool get isNotEmpty => accessToken.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Token &&
        other.accessToken == accessToken &&
        other.refreshToken == refreshToken &&
        other.expiresIn == expiresIn;
  }

  @override
  int get hashCode {
    return accessToken.hashCode ^ refreshToken.hashCode ^ expiresIn.hashCode;
  }

  Token copyWith({
    String? accessToken,
    String? refreshToken,
    int? expiresIn,
  }) {
    return Token(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresIn: expiresIn ?? this.expiresIn,
    );
  }

  @override
  String toString() {
    return 'Token(accessToken: ${accessToken.substring(0, 10)}..., refreshToken: ${refreshToken?.substring(0, 10)}..., expiresIn: $expiresIn)';
  }
}
