import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class FilterDiscountsUseCase implements UseCase<List<DiscountEntity>, bool?> {
  final DiscountRepository repository;

  FilterDiscountsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DiscountEntity>>> call(bool? isActive) async {
    return await repository.filterDiscounts(isActive: isActive);
  }
}
