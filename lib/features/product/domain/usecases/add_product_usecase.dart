import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// [AddProductUseCase] thêm một sản phẩm mới.
class AddProductUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  AddProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ProductEntity product) async {
    return await repository.addProduct(product);
  }
}
