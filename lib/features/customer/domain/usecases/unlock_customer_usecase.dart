import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/customer_repository.dart';

class UnlockCustomerUseCase implements UseCase<void, String> {
  final CustomerRepository repository;

  UnlockCustomerUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) async {
    return await repository.unlockCustomer(id);
  }
}
