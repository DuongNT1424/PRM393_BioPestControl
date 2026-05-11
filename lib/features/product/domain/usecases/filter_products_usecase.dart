import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class FilterProductParams extends Equatable {
  final int? categoryId;
  final bool? isActive;

  const FilterProductParams({this.categoryId, this.isActive});

  @override
  List<Object?> get props => [categoryId, isActive];
}

/// [FilterProductsUseCase] lọc sản phẩm theo danh mục và trạng thái.
class FilterProductsUseCase implements UseCase<List<ProductEntity>, FilterProductParams> {
  final ProductRepository repository;

  FilterProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ProductEntity>>> call(FilterProductParams params) async {
    return await repository.filterProducts(
      categoryId: params.categoryId,
      isActive: params.isActive,
    );
  }
}
