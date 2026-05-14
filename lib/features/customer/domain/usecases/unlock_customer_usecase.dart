import '../repositories/customer_repository.dart';

class UnlockCustomerUseCase {
  final CustomerRepository repository;

  UnlockCustomerUseCase(this.repository);

  Future<void> call(String id) async {
    return await repository.unlockCustomer(id);
  }
}
