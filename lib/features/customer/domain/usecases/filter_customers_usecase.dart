import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class FilterCustomersUseCase {
  final CustomerRepository repository;

  FilterCustomersUseCase(this.repository);

  Future<List<CustomerEntity>> call({bool? isLocked}) async {
    return await repository.filterCustomers(isLocked: isLocked);
  }
}
