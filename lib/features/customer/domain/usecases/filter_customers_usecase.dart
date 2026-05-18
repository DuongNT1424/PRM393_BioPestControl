import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/customer_entity.dart';
import '../repositories/customer_repository.dart';

class FilterCustomersUseCase implements UseCase<List<CustomerEntity>, bool?> {
  final CustomerRepository repository;

  FilterCustomersUseCase(this.repository);

  @override
  Future<Either<Failure, List<CustomerEntity>>> call(bool? isLocked) async {
    return await repository.filterCustomers(isLocked: isLocked);
  }
}
