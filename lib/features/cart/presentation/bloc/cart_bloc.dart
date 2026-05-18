import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_quantity_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final GetCartUseCase getCartUseCase;
  final AddToCartUseCase addToCartUseCase;
  final RemoveFromCartUseCase removeFromCartUseCase;
  final UpdateCartQuantityUseCase updateCartQuantityUseCase;
  final ClearCartUseCase clearCartUseCase;

  CartBloc({
    required this.getCartUseCase,
    required this.addToCartUseCase,
    required this.removeFromCartUseCase,
    required this.updateCartQuantityUseCase,
    required this.clearCartUseCase,
  }) : super(const CartState()) {
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    final result = await getCartUseCase();
    result.fold(
      (failure) => null, // Có thể handle error nếu cần thiết
      (items) => emit(state.copyWith(items: items)),
    );
  }

  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    final result = await addToCartUseCase(AddToCartParams(product: event.product, quantity: event.quantity));
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()), // Tải lại sau khi thêm
    );
  }

  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final result = await removeFromCartUseCase(event.productId);
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()),
    );
  }

  Future<void> _onUpdateQuantity(UpdateCartItemQuantityEvent event, Emitter<CartState> emit) async {
    final result = await updateCartQuantityUseCase(
        UpdateCartQuantityParams(productId: event.productId, quantity: event.quantity));
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()),
    );
  }

  Future<void> _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    final result = await clearCartUseCase();
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()),
    );
  }
}
