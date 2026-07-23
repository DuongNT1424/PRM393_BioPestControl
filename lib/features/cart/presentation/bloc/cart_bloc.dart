import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_to_cart_usecase.dart';
import '../../domain/usecases/clear_cart_usecase.dart';
import '../../domain/usecases/get_cart_usecase.dart';
import '../../domain/usecases/remove_from_cart_usecase.dart';
import '../../domain/usecases/update_cart_quantity_usecase.dart';
import 'cart_event.dart';
import 'cart_state.dart';

/// [CartBloc] Quản lý trạng thái (State) của Giỏ hàng.
/// Đây là cầu nối giữa UI (Presentation Layer) và Logic Nghiệp vụ (Domain Layer).
/// - Nhận các sự kiện (Events) từ UI như: Load, Add, Remove, Update, Clear.
/// - Gọi các UseCases tương ứng để thực hiện logic và thay đổi dữ liệu.
/// - Phát ra (Emit) trạng thái mới (CartState) để UI cập nhật giao diện.
class CartBloc extends Bloc<CartEvent, CartState> {
  // Các UseCases được tiêm vào (Dependency Injection) để Bloc gọi
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
    // Đăng ký xử lý cho từng loại sự kiện
    on<LoadCartEvent>(_onLoadCart);
    on<AddToCartEvent>(_onAddToCart);
    on<RemoveFromCartEvent>(_onRemoveFromCart);
    on<UpdateCartItemQuantityEvent>(_onUpdateQuantity);
    on<ClearCartEvent>(_onClearCart);
  }

  /// Xử lý sự kiện tải dữ liệu giỏ hàng.
  /// Gọi [GetCartUseCase] để lấy danh sách sản phẩm từ Repository.
  Future<void> _onLoadCart(LoadCartEvent event, Emitter<CartState> emit) async {
    final result = await getCartUseCase();
    result.fold(
      (failure) => null, // Xử lý lỗi nếu cần thiết (ví dụ: emit trạng thái lỗi)
      (items) => emit(state.copyWith(items: items)), // Cập nhật danh sách mới vào State
    );
  }

  /// Xử lý sự kiện thêm một sản phẩm vào giỏ hàng.
  /// Gọi [AddToCartUseCase] truyền vào sản phẩm và số lượng.
  Future<void> _onAddToCart(AddToCartEvent event, Emitter<CartState> emit) async {
    final result = await addToCartUseCase(AddToCartParams(product: event.product, quantity: event.quantity));
    result.fold(
      (failure) => null,
      // Nếu thêm thành công, phát sự kiện [LoadCartEvent] để lấy lại danh sách mới nhất
      (_) => add(LoadCartEvent()), 
    );
  }

  /// Xử lý sự kiện xóa một sản phẩm khỏi giỏ hàng dựa theo ID.
  /// Gọi [RemoveFromCartUseCase].
  Future<void> _onRemoveFromCart(RemoveFromCartEvent event, Emitter<CartState> emit) async {
    final result = await removeFromCartUseCase(event.productId);
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()), // Cập nhật lại giỏ hàng sau khi xóa
    );
  }

  /// Xử lý sự kiện cập nhật số lượng của một sản phẩm trong giỏ hàng.
  /// Gọi [UpdateCartQuantityUseCase].
  Future<void> _onUpdateQuantity(UpdateCartItemQuantityEvent event, Emitter<CartState> emit) async {
    final result = await updateCartQuantityUseCase(
        UpdateCartQuantityParams(productId: event.productId, quantity: event.quantity));
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()), // Cập nhật lại giỏ hàng sau khi thay đổi số lượng
    );
  }

  /// Xử lý sự kiện xóa toàn bộ giỏ hàng.
  /// Gọi [ClearCartUseCase].
  Future<void> _onClearCart(ClearCartEvent event, Emitter<CartState> emit) async {
    final result = await clearCartUseCase();
    result.fold(
      (failure) => null,
      (_) => add(LoadCartEvent()), // Làm mới giao diện (giỏ hàng trống)
    );
  }
}
