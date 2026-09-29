import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/domain/failures/failures.dart';

class RegisterUseCase {
  final FirebaseAuthService firebaseAuthService;

  RegisterUseCase(this.firebaseAuthService);

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
    String? name,
  }) async {
    try {
      await firebaseAuthService.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: name,
      );
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(message: e.toString()));
    }
  }
}
