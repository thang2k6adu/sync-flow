/// Either type for functional error handling
/// Represents a value that can be either Left (error) or Right (success)
abstract class Either<L, R> {
  const Either();

  /// Check if this is a Left value
  bool get isLeft;

  /// Check if this is a Right value
  bool get isRight => !isLeft;

  /// Fold the Either value into a single result
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR);

  /// Get the Right value or throw if this is Left
  R get right {
    if (this is Right<L, R>) {
      return (this as Right<L, R>).value;
    }
    throw Exception('Called .right on a Left value');
  }

  /// Get the Left value or throw if this is Right
  L get left {
    if (this is Left<L, R>) {
      return (this as Left<L, R>).value;
    }
    throw Exception('Called .left on a Right value');
  }

  /// Get the Right value or return a default
  R getOrElse(R Function() orElse) {
    return fold((_) => orElse(), (r) => r);
  }
}

/// Left (error) side of Either
class Left<L, R> extends Either<L, R> {
  final L value;

  const Left(this.value);

  @override
  bool get isLeft => true;

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnL(value);
  }

  @override
  String toString() => 'Left($value)';

  @override
  bool operator ==(Object other) {
    return other is Left<L, R> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}

/// Right (success) side of Either
class Right<L, R> extends Either<L, R> {
  final R value;

  const Right(this.value);

  @override
  bool get isLeft => false;

  @override
  T fold<T>(T Function(L left) fnL, T Function(R right) fnR) {
    return fnR(value);
  }

  @override
  String toString() => 'Right($value)';

  @override
  bool operator ==(Object other) {
    return other is Right<L, R> && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;
}
