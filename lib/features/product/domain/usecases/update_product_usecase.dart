import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// [UpdateProductUseCase] cập nhật thông tin sản phẩm.
class UpdateProductUseCase implements UseCase<void, ProductEntity> {
  final ProductRepository repository;

  UpdateProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ProductEntity product) async {
    return await repository.updateProduct(product);
  }
}
