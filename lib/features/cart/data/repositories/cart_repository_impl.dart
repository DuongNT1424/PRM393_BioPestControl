import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/cart/data/datasources/cart_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/entities/cart_item_entity.dart';
import 'package:prm393_biopestcontrol/features/cart/data/models/cart_item_model.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource localDataSource;

  CartRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CartItemEntity>>> getCart() async {
    try {
      final items = await localDataSource.getCart();
      return Right(items);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addToCart(ProductEntity product, int quantity) async {
    try {
      final model = CartItemModel(product: product, quantity: quantity);
      await localDataSource.addToCart(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromCart(int productId) async {
    try {
      await localDataSource.removeFromCart(productId);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateQuantity(int productId, int quantity) async {
    try {
      await localDataSource.updateQuantity(productId, quantity);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> clearCart() async {
    try {
      await localDataSource.clearCart();
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
