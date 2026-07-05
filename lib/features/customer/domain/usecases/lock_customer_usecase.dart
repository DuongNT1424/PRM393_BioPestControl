import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/customer_repository.dart';

class LockCustomerUseCase implements UseCase<void, String> {
  final CustomerRepository repository;

  LockCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.lockCustomer(id);
  }
}
