import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/customer_entity.dart';
/// [CustomerRepository] định nghĩa các bản hợp đồng (interface) cho nghiệp vụ khách hàng.
/// Tầng Presentation và UseCase sẽ gọi qua đây mà không cần biết dữ liệu lấy từ đâu (Firestore hay SQL).
abstract class CustomerRepository {
  Future<Either<Failure, List<CustomerEntity>>> getCustomers();
  Future<Either<Failure, CustomerEntity>> getCustomerById(String id);
  Future<Either<Failure, void>> updateCustomer(CustomerEntity customer);
  Future<Either<Failure, void>> lockCustomer(String id);
  Future<Either<Failure, void>> unlockCustomer(String id);
  Future<Either<Failure, List<CustomerEntity>>> searchCustomers(String query);
  Future<Either<Failure, List<CustomerEntity>>> filterCustomers({bool? isLocked});
}
