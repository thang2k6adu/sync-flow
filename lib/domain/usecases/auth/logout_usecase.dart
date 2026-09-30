import 'package:pp191225/core/utils/either.dart';
import 'package:pp191225/data/services/firebase_auth_service.dart';
import 'package:pp191225/domain/failures/failures.dart';
import 'package:pp191225/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository repository;
  final FirebaseAuthService firebaseAuthService;

  LogoutUseCase({required this.repository, required this.firebaseAuthService});

  Future<Either<Failure, void>> call() async {
    try {
      await repository.logout();
    } catch (_) {
      // BE lỗi vẫn phải thoát Firebase và xoá token local
    }

    try {
      await firebaseAuthService.signOut();
    } catch (_) {
      // Firebase lỗi không được chặn việc xoá token local
    }

    return await repository.clearTokens();
  }
}
