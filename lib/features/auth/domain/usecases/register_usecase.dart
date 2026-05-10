import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

/// UseCase thực hiện đăng ký tài khoản người dùng mới.
class RegisterUseCase implements UseCase<AuthEntity, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity>> call(RegisterParams params) async {
    return await repository.register(
      email: params.email,
      password: params.password,
      name: params.name,
    );
  }
}

/// Tham số đầu vào cho việc đăng ký
class RegisterParams {
  final String email;
  final String password;
  final String name;

  RegisterParams({
    required this.email,
    required this.password,
    required this.name,
  });
}
