import 'package:equatable/equatable.dart';
import '../../domain/entities/cart_item_entity.dart';

class CartState extends Equatable {
  final List<CartItemEntity> items;

  const CartState({this.items = const []});

  double get totalPrice => items.fold(0, (total, item) => total + (item.product.price * item.quantity));
  int get totalItems => items.fold(0, (total, item) => total + item.quantity);

  CartState copyWith({
    List<CartItemEntity>? items,
  }) {
    return CartState(
      items: items ?? this.items,
    );
  }

  @override
  List<Object> get props => [items];
}
