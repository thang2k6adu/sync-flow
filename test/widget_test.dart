import 'package:flutter_test/flutter_test.dart';
import 'package:pp191225/core/utils/either.dart';

void main() {
  group('Either Unit Tests', () {
    test('Left should correctly identify as Left and return folded value', () {
      const Either<String, int> either = Left('error_occurred');

      expect(either.isLeft, isTrue);
      expect(either.isRight, isFalse);
      expect(either.left, 'error_occurred');

      final result = either.fold(
        (left) => 'Handled: $left',
        (right) => 'Value: $right',
      );
      expect(result, 'Handled: error_occurred');
    });

    test('Right should correctly identify as Right and return folded value', () {
      const Either<String, int> either = Right(42);

      expect(either.isLeft, isFalse);
      expect(either.isRight, isTrue);
      expect(either.right, 42);

      final result = either.fold(
        (left) => 'Handled: $left',
        (right) => 'Value: $right',
      );
      expect(result, 'Value: 42');
    });

    test('getOrElse should return right value or fallback', () {
      const Either<String, int> right = Right(100);
      const Either<String, int> left = Left('err');

      expect(right.getOrElse(() => 0), 100);
      expect(left.getOrElse(() => 0), 0);
    });
  });
}
