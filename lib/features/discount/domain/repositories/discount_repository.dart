import '../entities/discount_entity.dart';

/// [DiscountRepository] là interface định nghĩa các phương thức tương tác với dữ liệu Giảm giá.
/// Tầng Presentation và Domain sẽ gọi qua giao diện này để đảm bảo tính độc lập.
abstract class DiscountRepository {
  /// Lấy toàn bộ danh sách giảm giá từ database.
  Future<List<DiscountEntity>> getDiscounts();

  /// Lấy thông tin chi tiết của một mã giảm giá.
  Future<DiscountEntity> getDiscountById(int id);

  /// Thêm một chương trình giảm giá mới.
  Future<void> addDiscount(DiscountEntity discount);

  /// Cập nhật thông tin của chương trình giảm giá hiện có.
  Future<void> updateDiscount(DiscountEntity discount);

  /// Xóa mã giảm giá.
  Future<void> deleteDiscount(int id);

  /// Tìm kiếm mã giảm giá theo tên hoặc tên sản phẩm liên quan.
  Future<List<DiscountEntity>> searchDiscounts(String query);

  /// Lọc danh sách theo trạng thái hoạt động.
  Future<List<DiscountEntity>> filterDiscounts({bool? isActive});
}
