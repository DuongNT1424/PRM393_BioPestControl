import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
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
  Future<Either<Failure, List<CustomerEntity>>> getCustomers() async {
    try {
      final models = await remoteDataSource.getCustomers();
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> getCustomerById(String id) async {
    try {
      final model = await remoteDataSource.getCustomerById(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateCustomer(CustomerEntity customer) async {
    try {
      final model = CustomerModel.fromEntity(customer);
      await remoteDataSource.updateCustomer(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> lockCustomer(String id) async {
    try {
      await remoteDataSource.setCustomerLockStatus(id, true);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unlockCustomer(String id) async {
    try {
      await remoteDataSource.setCustomerLockStatus(id, false);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CustomerEntity>>> searchCustomers(String query) async {
    try {
      final models = await remoteDataSource.searchCustomers(query);
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CustomerEntity>>> filterCustomers({bool? isLocked}) async {
    try {
      final models = await remoteDataSource.filterCustomers(isLocked: isLocked);
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
