import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class UpdateDiscountUseCase implements UseCase<void, DiscountEntity> {
  final DiscountRepository repository;
  UpdateDiscountUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(DiscountEntity discount) async {
    return await repository.updateDiscount(discount);
  }
}
