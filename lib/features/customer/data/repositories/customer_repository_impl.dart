import '../../domain/entities/customer_entity.dart';
import '../../domain/repositories/customer_repository.dart';
import '../datasources/customer_remote_data_source.dart';
import '../models/customer_model.dart';

/// [CustomerRepositoryImpl] là cầu nối giữa Domain Layer và Data Layer.
/// Nó thực hiện việc chuyển đổi (mapping) giữa Model và Entity.
class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDataSource remoteDataSource;

  CustomerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<CustomerEntity>> getCustomers() async {
    final models = await remoteDataSource.getCustomers();
    // Chuyển đổi từ danh sách Model sang danh sách Entity
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<CustomerEntity> getCustomerById(String id) async {
    final model = await remoteDataSource.getCustomerById(id);
    return model.toEntity();
  }

  @override
  Future<void> updateCustomer(CustomerEntity customer) async {
    // Chuyển Entity sang Model để phù hợp với Data Source
    final model = CustomerModel.fromEntity(customer);
    await remoteDataSource.updateCustomer(model);
  }

  @override
  Future<void> lockCustomer(String id) async {
    await remoteDataSource.setCustomerLockStatus(id, true);
  }

  @override
  Future<void> unlockCustomer(String id) async {
    await remoteDataSource.setCustomerLockStatus(id, false);
  }

  @override
  Future<List<CustomerEntity>> searchCustomers(String query) async {
    final models = await remoteDataSource.searchCustomers(query);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<CustomerEntity>> filterCustomers({bool? isLocked}) async {
    final models = await remoteDataSource.filterCustomers(isLocked: isLocked);
    return models.map((model) => model.toEntity()).toList();
  }
}
