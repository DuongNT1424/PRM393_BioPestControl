import 'package:prm393_biopestcontrol/features/cart/data/models/cart_item_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartItemModel>> getCart();
  Future<void> addToCart(CartItemModel item);
  Future<void> removeFromCart(int productId);
  Future<void> updateQuantity(int productId, int quantity);
  Future<void> clearCart();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final List<CartItemModel> _cartItems = [];

  @override
  Future<List<CartItemModel>> getCart() async {
    return List.from(_cartItems);
  }

  @override
  Future<void> addToCart(CartItemModel item) async {
    final existingIndex = _cartItems.indexWhere((i) => i.product.id == item.product.id);
    if (existingIndex >= 0) {
      final existingItem = _cartItems[existingIndex];
      if (existingItem.quantity + item.quantity <= item.product.stock) {
        _cartItems[existingIndex] = CartItemModel(
          product: existingItem.product,
          quantity: existingItem.quantity + item.quantity,
        );
      }
    } else {
      if (item.quantity <= item.product.stock) {
        _cartItems.add(item);
      }
    }
  }

  @override
  Future<void> removeFromCart(int productId) async {
    _cartItems.removeWhere((item) => item.product.id == productId);
  }

  @override
  Future<void> updateQuantity(int productId, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.product.id == productId);
    if (index >= 0) {
      final product = _cartItems[index].product;
      if (quantity > 0 && quantity <= product.stock) {
        _cartItems[index] = CartItemModel(
          product: product,
          quantity: quantity,
        );
      } else if (quantity == 0) {
        _cartItems.removeAt(index);
      }
    }
  }

  @override
  Future<void> clearCart() async {
    _cartItems.clear();
  }
}
