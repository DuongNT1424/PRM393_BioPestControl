import '../repositories/discount_repository.dart';

class DeleteDiscountUseCase {
  final DiscountRepository repository;
  DeleteDiscountUseCase(this.repository);

  Future<void> call(int id) async {
    return await repository.deleteDiscount(id);
  }
}
