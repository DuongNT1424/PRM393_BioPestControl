import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class SearchDiscountsUseCase implements UseCase<List<DiscountEntity>, String> {
  final DiscountRepository repository;
  SearchDiscountsUseCase(this.repository);

  @override
  Future<Either<Failure, List<DiscountEntity>>> call(String query) async {
    return await repository.searchDiscounts(query);
  }
}
