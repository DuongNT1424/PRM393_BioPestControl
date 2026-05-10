import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

/// UseCase thực hiện đăng xuất khỏi hệ thống.
class LogoutUseCase implements UseCase<void, void> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await repository.logout();
  }
}
