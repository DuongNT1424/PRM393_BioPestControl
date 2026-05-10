import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_entity.dart';
import '../repositories/auth_repository.dart';

/// UseCase lấy thông tin người dùng đang đăng nhập hiện tại.
class GetCurrentUserUseCase implements UseCase<AuthEntity?, void> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, AuthEntity?>> call(void params) async {
    return await repository.getCurrentUser();
  }
}
