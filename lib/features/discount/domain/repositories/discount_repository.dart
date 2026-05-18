import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/discount_entity.dart';
/// [DiscountRepository] là interface định nghĩa các phương thức tương tác với dữ liệu Giảm giá.
/// Tầng Presentation và Domain sẽ gọi qua giao diện này để đảm bảo tính độc lập.
abstract class DiscountRepository {
  /// Lấy toàn bộ danh sách giảm giá từ database.
  Future<Either<Failure, List<DiscountEntity>>> getDiscounts();

  /// Lấy thông tin chi tiết của một mã giảm giá.
  Future<Either<Failure, DiscountEntity>> getDiscountById(int id);

  /// Thêm một chương trình giảm giá mới.
  Future<Either<Failure, void>> addDiscount(DiscountEntity discount);

  /// Cập nhật thông tin của chương trình giảm giá hiện có.
  Future<Either<Failure, void>> updateDiscount(DiscountEntity discount);

  /// Xóa mã giảm giá.
  Future<Either<Failure, void>> deleteDiscount(int id);

  /// Tìm kiếm mã giảm giá theo tên hoặc tên sản phẩm liên quan.
  Future<Either<Failure, List<DiscountEntity>>> searchDiscounts(String query);

  /// Lọc danh sách theo trạng thái hoạt động.
  Future<Either<Failure, List<DiscountEntity>>> filterDiscounts({bool? isActive});
}
