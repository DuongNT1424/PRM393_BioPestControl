import 'package:equatable/equatable.dart';
import '../../../product/domain/entities/product_entity.dart';

// CartEvent là lớp cha (abstract class) của tất cả các sự kiện liên quan đến giỏ hàng.
// Các event sẽ được gửi từ UI đến CartBloc để yêu cầu thực hiện một hành động.
abstract class CartEvent extends Equatable {
  const CartEvent();

  // Equatable dùng để so sánh event theo giá trị.
  @override
  List<Object> get props => [];
}

// ==========================================================
// Event: Tải dữ liệu giỏ hàng
// ==========================================================
// Được gọi khi mở ứng dụng hoặc mở CartPage.
// CartBloc sẽ lấy dữ liệu từ local database hoặc repository.
class LoadCartEvent extends CartEvent {}

// ==========================================================
// Event: Thêm sản phẩm vào giỏ hàng
// ==========================================================
class AddToCartEvent extends CartEvent {

  // Sản phẩm cần thêm
  final ProductEntity product;

  // Số lượng muốn thêm
  final int quantity;

  // quantity mặc định = 1 nếu không truyền vào
  const AddToCartEvent(this.product, {this.quantity = 1});

  @override
  List<Object> get props => [product, quantity];
}

// ==========================================================
// Event: Xóa một sản phẩm khỏi giỏ hàng
// ==========================================================
class RemoveFromCartEvent extends CartEvent {

  // ID của sản phẩm cần xóa
  final int productId;

  const RemoveFromCartEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

// ==========================================================
// Event: Cập nhật số lượng sản phẩm
// ==========================================================
class UpdateCartItemQuantityEvent extends CartEvent {

  // ID sản phẩm cần cập nhật
  final int productId;

  // Số lượng mới
  final int quantity;

  const UpdateCartItemQuantityEvent(this.productId, this.quantity);

  @override
  List<Object> get props => [productId, quantity];
}

// ==========================================================
// Event: Xóa toàn bộ giỏ hàng
// ==========================================================
// Không cần truyền dữ liệu vì chỉ có một hành động duy nhất:
// làm rỗng danh sách sản phẩm.
class ClearCartEvent extends CartEvent {}