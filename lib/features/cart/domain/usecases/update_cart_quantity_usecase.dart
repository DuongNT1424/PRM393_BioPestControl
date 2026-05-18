import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';

class UpdateCartQuantityParams {
  final int productId;
  final int quantity;

  UpdateCartQuantityParams({required this.productId, required this.quantity});
}

class UpdateCartQuantityUseCase {
  final CartRepository repository;

  UpdateCartQuantityUseCase(this.repository);

  Future<Either<Failure, void>> call(UpdateCartQuantityParams params) {
    return repository.updateQuantity(params.productId, params.quantity);
  }
}
