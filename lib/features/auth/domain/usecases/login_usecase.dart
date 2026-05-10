import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

/// UseCase thực hiện nghiệp vụ Đăng nhập.
/// Tuân thủ nguyên tắc Single Responsibility: Mỗi UseCase chỉ làm một việc duy nhất.
class LoginUseCase implements UseCase<AuthEntity, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  // Phương thức thực thi logic của UseCase
  Future<Either<Failure, AuthEntity>> call(LoginParams params) async {
    return await repository.login(
      email: params.email,
      password: params.password,
    );
  }
}

/// Lớp chứa các tham số đầu vào cho LoginUseCase
class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}
