import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

/// UseCase thực hiện đăng nhập bằng tài khoản Google.
class LoginWithGoogleUseCase implements UseCase<AuthEntity, void> {
  final AuthRepository repository;

  LoginWithGoogleUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(void params) async {
    return await repository.loginWithGoogle();
  }
}
