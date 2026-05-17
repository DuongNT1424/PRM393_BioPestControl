import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class AddDiscountUseCase {
  final DiscountRepository repository;
  AddDiscountUseCase(this.repository);

  Future<void> call(DiscountEntity discount) async {
    return await repository.addDiscount(discount);
  }
}
