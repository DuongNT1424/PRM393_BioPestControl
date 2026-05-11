import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

/// [GetProductUseCase] lấy chi tiết một sản phẩm theo ID.
class GetProductUseCase implements UseCase<ProductEntity, int> {
  final ProductRepository repository;

  GetProductUseCase(this.repository);

  @override
  Future<Either<Failure, ProductEntity>> call(int id) async {
    return await repository.getProductById(id);
  }
}
