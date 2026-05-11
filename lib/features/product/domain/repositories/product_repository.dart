import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/product_entity.dart';

/// [ProductRepository] định nghĩa các hành động cho tính năng Sản phẩm.
abstract class ProductRepository {
  /// Lấy danh sách tất cả sản phẩm.
  Future<Either<Failure, List<ProductEntity>>> getProducts();
  
  /// Tìm kiếm sản phẩm theo tên hoặc SKU.
  Future<Either<Failure, List<ProductEntity>>> searchProducts(String query);
  
  /// Thêm sản phẩm mới.
  Future<Either<Failure, void>> addProduct(ProductEntity product);
  
  /// Cập nhật thông tin sản phẩm.
  Future<Either<Failure, void>> updateProduct(ProductEntity product);
  
  /// Xóa sản phẩm (Soft delete hoặc Hard delete tùy chọn).
  Future<Either<Failure, void>> deleteProduct(int id);
}
