import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class GetCustomerDetailUseCase implements UseCase<CustomerEntity, String> {
  final CustomerRepository repository;

  GetCustomerDetailUseCase(this.repository);

  @override
  Future<Either<Failure, CustomerEntity>> call(String id) async {
    return await repository.getCustomerById(id);
  }
}
