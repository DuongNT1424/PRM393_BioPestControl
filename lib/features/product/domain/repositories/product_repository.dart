import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

/// [ProductRepository] định nghĩa các hành động cho tính năng Sản phẩm.
abstract class ProductRepository {
  /// Lấy danh sách tất cả sản phẩm.
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  
  /// Lấy chi tiết một sản phẩm theo ID.
  Future<Either<Failure, ProductEntity>> getProductById(int id);
  
  /// Tìm kiếm sản phẩm theo tên hoặc SKU.
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);

  /// Lọc sản phẩm theo danh mục và trạng thái.
  Future<Either<Failure, List<ProductEntity>>> filterProducts({int? categoryId, bool? isActive});
  
  /// Thêm sản phẩm mới.
  Future<Either<Failure, void>> addProduct(ProductEntity product);
  
  /// Cập nhật thông tin sản phẩm.
  Future<Either<Failure, void>> updateProduct(ProductEntity product);
  
  /// Xóa sản phẩm.
  Future<Either<Failure, void>> deleteProduct(int id);
}
