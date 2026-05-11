import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts() async {
    try {
      final products = await localDataSource.getProducts();
      return Right<Failure, List<ProductEntity>>(products);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể tải danh sách sản phẩm'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query) async {
    try {
      final products = await localDataSource.searchProducts(query);
      return Right<Failure, List<ProductEntity>>(products);
    } catch (e) {
      return const Left(DatabaseFailure('Lỗi khi tìm kiếm sản phẩm'));
    }
  }

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product) async {
    try {
      final model = ProductModel(
        sku: product.sku,
        name: product.name,
        description: product.description,
        price: product.price,
        stock: product.stock,
        categoryId: product.categoryId,
        isActive: product.isActive,
        imageUrl: product.imageUrl,
      );
      await localDataSource.addProduct(model);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể thêm sản phẩm mới'));
    }
  }

  @override
  Future<Either<Failure, void>> updateProduct(ProductEntity product) async {
    try {
      final model = ProductModel(
        id: product.id,
        sku: product.sku,
        name: product.name,
        description: product.description,
        price: product.price,
        stock: product.stock,
        categoryId: product.categoryId,
        isActive: product.isActive,
        imageUrl: product.imageUrl,
      );
      await localDataSource.updateProduct(model);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể cập nhật sản phẩm'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(int id) async {
    try {
      await localDataSource.deleteProduct(id);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể xóa sản phẩm'));
    }
  }
}
