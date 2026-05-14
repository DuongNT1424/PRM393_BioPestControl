import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class SearchCustomersUseCase {
  final CustomerRepository repository;

  SearchCustomersUseCase(this.repository);

  Future<List<CustomerEntity>> call(String query) async {
    return await repository.searchCustomers(query);
  }
}
