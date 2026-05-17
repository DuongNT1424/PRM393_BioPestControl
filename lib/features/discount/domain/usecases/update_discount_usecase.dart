import '../repositories/discount_repository.dart';
import '../entities/discount_entity.dart';

class UpdateDiscountUseCase {
  final DiscountRepository repository;
  UpdateDiscountUseCase(this.repository);

  Future<void> call(DiscountEntity discount) async {
    return await repository.updateDiscount(discount);
  }
}
