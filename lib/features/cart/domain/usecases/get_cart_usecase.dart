import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/entities/cart_item_entity.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';

class GetCartUseCase {
  final CartRepository repository;

  GetCartUseCase(this.repository);

  Future<Either<Failure, List<CartItemEntity>>> call() {
    return repository.getCart();
  }
}
