import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/product_repository.dart';

/// [DeleteProductUseCase] xóa sản phẩm theo ID.
class DeleteProductUseCase implements UseCase<void, int> {
  final ProductRepository repository;

  DeleteProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteProduct(id);
  }
}
