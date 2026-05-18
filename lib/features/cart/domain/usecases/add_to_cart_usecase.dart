import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';

class AddToCartParams {
  final ProductEntity product;
  final int quantity;

  AddToCartParams({required this.product, required this.quantity});
}

class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  Future<Either<Failure, void>> call(AddToCartParams params) {
    return repository.addToCart(params.product, params.quantity);
  }
}
