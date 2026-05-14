import '../repositories/customer_repository.dart';

class LockCustomerUseCase {
  final CustomerRepository repository;

  LockCustomerUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.lockCustomer(id);
  }
}
