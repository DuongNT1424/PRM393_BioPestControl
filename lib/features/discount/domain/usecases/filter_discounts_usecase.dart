import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class FilterDiscountsUseCase {
  final DiscountRepository repository;
  FilterDiscountsUseCase(this.repository);

  Future<List<DiscountEntity>> call({bool? isActive}) async {
    return await repository.filterDiscounts(isActive: isActive);
  }
}
