import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class GetDiscountsUseCase implements UseCase<List<DiscountEntity>, NoParams> {
  final DiscountRepository repository;
  GetDiscountsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DiscountEntity>>> call(NoParams params) async {
    return await repository.getDiscounts();
  }
}
