import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class GetDiscountsUseCase {
  final DiscountRepository repository;
  GetDiscountsUseCase(this.repository);

  Future<List<DiscountEntity>> call() async {
    return await repository.getDiscounts();
  }
}
