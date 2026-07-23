import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

// CartState đại diện cho trạng thái hiện tại của giỏ hàng.
// Kế thừa Equatable để có thể so sánh các state theo giá trị thay vì so sánh địa chỉ bộ nhớ.
class CartState extends Equatable {

  // Danh sách sản phẩm trong giỏ hàng.
  final List<CartItemEntity> items;

  // Constructor với giá trị mặc định là danh sách rỗng.
  const CartState({this.items = const []});

  // Getter tính tổng tiền của giỏ hàng.
  //
  // fold(0, ...) hoạt động như sau:
  // - bắt đầu với total = 0
  // - duyệt từng item trong danh sách
  // - cộng giá sản phẩm * số lượng vào total
  //
  // Ví dụ:
  // SP1: 100k x 2 = 200k
  // SP2: 50k x 1 = 50k
  // Kết quả = 250k
  double get totalPrice => items.fold(
        0,
        (total, item) =>
            total + (item.product.price * item.quantity),
      );

  // Getter tính tổng số lượng sản phẩm trong giỏ hàng.
  //
  // Ví dụ:
  // SP1: 2
  // SP2: 1
  // Kết quả = 3 sản phẩm
  int get totalItems => items.fold(
        0,
        (total, item) => total + item.quantity,
      );

  // copyWith dùng để tạo ra một state mới
  // mà vẫn giữ lại các giá trị cũ nếu không truyền vào.
  //
  // Đây là cách cập nhật state theo hướng immutable
  // (không thay đổi object cũ).
  //
  // Ví dụ:
  // emit(state.copyWith(items: newItems));
  CartState copyWith({
    List<CartItemEntity>? items,
  }) {
    return CartState(

      // Nếu items khác null -> dùng items mới
      // Nếu items null -> giữ nguyên items hiện tại
      items: items ?? this.items,
    );
  }

  // Equatable sẽ dùng props để so sánh state.
  // Nếu danh sách items thay đổi,BlocBuilder sẽ biết state đã thay đổi và tự động rebuild giao diện.
  @override
  List<Object> get props => [items];
}
