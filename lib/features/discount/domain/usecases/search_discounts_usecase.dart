import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class SearchDiscountsUseCase {
  final DiscountRepository repository;
  SearchDiscountsUseCase(this.repository);

  Future<List<DiscountEntity>> call(String query) async {
    return await repository.searchDiscounts(query);
  }
}
