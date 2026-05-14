import '../entities/customer_entity.dart';

/// [CustomerRepository] định nghĩa các bản hợp đồng (interface) cho nghiệp vụ khách hàng.
/// Tầng Presentation và UseCase sẽ gọi qua đây mà không cần biết dữ liệu lấy từ đâu (Firestore hay SQL).
abstract class CustomerRepository {
  Future<List<CustomerEntity>> getCustomers();
  Future<CustomerEntity> getCustomerById(String id);
  Future<void> updateCustomer(CustomerEntity customer);
  Future<void> lockCustomer(String id);
  Future<void> unlockCustomer(String id);
  Future<List<CustomerEntity>> searchCustomers(String query);
  Future<List<CustomerEntity>> filterCustomers({bool? isLocked});
}
