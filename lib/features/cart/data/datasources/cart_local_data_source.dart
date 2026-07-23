import 'package:prm393_biopestcontrol/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCart();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

/// [CartLocalDataSourceImpl] Chịu trách nhiệm trực tiếp thao tác với bộ nhớ.
/// Ở phiên bản hiện tại, dữ liệu được lưu tạm thời trên RAM (List _cartItems).
/// - Xử lý logic cấp thấp như kiểm tra trùng lặp (cộng dồn số lượng).
/// - Kiểm tra điều kiện tồn kho (stock) trước khi thêm/sửa số lượng.
class CartLocalDataSourceImpl implements CartLocalDataSource {
  // Biến lưu trữ giỏ hàng hiện tại (chưa lưu vào ổ cứng)
  final List<CartItemModel> _cartItems = [];

  @override
  Future<List<CartItemModel>> getCart() async {
    // Trả về bản sao của list hiện tại
    return List.from(_cartItems);
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final existingIndex = _cartItems.indexWhere((i) => i.product.id == item.product.id);
    if (existingIndex >= 0) {
      // Nếu sản phẩm đã có trong giỏ, cập nhật số lượng
      final existingItem = _cartItems[existingIndex];
      if (existingItem.quantity + item.quantity <= item.product.stock) {
        _cartItems[existingIndex] = CartItemModel(
          product: existingItem.product,
          quantity: existingItem.quantity + item.quantity,
        );
      }
    } else {
      // Nếu sản phẩm chưa có, thêm mới (đảm bảo không vượt tồn kho)
      if (item.quantity <= item.product.stock) {
        _cartItems.add(item);
      }
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    // Xóa sản phẩm khỏi danh sách theo ID
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final product = _cartItems[index].product;
      // Cập nhật nếu số lượng hợp lệ (lớn hơn 0 và không vượt quá tồn kho)
      if (quantity > 0 && quantity <= product.stock) {
        _cartItems[index] = CartItemModel(
          product: product,
          quantity: quantity,
        );
      } else if (quantity == 0) {
        // Nếu giảm về 0 thì tự động xóa khỏi giỏ
        _cartItems.removeAt(index);
      }
    }
  }

  @override
  Future<void> clearCart() async {
    // Xóa toàn bộ sản phẩm khỏi giỏ
    _cartItems.clear();
  }
}
