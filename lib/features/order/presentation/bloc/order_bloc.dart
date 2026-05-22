import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/create_order.dart';
import '../../domain/usecases/get_orders.dart';
import '../../domain/usecases/get_order_detail.dart';
import '../../domain/usecases/update_order_status.dart';
import 'order_event.dart';
import 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final CreateOrderUseCase createOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final GetOrderDetailUseCase getOrderDetailUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;

  OrderBloc({
    required this.createOrderUseCase,
    required this.getOrdersUseCase,
    required this.getOrderDetailUseCase,
    required this.updateOrderStatusUseCase,
  }) : super(OrderInitial()) {
    on<CreateOrderEvent>(_onCreateOrder);
    on<LoadOrdersEvent>(_onLoadOrders);
    on<LoadOrderDetailEvent>(_onLoadOrderDetail);
    on<UpdateOrderStatusEvent>(_onUpdateOrderStatus);
  }

  Future<void> _onCreateOrder(CreateOrderEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await createOrderUseCase(event.order);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orderId) => emit(OrderActionSuccess(orderId: orderId, message: 'Đặt hàng thành công!')),
    );
  }

  Future<void> _onLoadOrders(LoadOrdersEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await getOrdersUseCase(GetOrdersParams(
      customerId: event.customerId,
      deliveryStatus: event.deliveryStatus,
      searchQuery: event.searchQuery,
    ));
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (orders) => emit(OrdersLoaded(orders)),
    );
  }

  Future<void> _onLoadOrderDetail(LoadOrderDetailEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await getOrderDetailUseCase(event.orderId);
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (order) => emit(OrderDetailLoaded(order)),
    );
  }

  Future<void> _onUpdateOrderStatus(UpdateOrderStatusEvent event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    final result = await updateOrderStatusUseCase(UpdateOrderStatusParams(
      orderId: event.orderId,
      deliveryStatus: event.deliveryStatus,
      paymentStatus: event.paymentStatus,
    ));
    result.fold(
      (failure) => emit(OrderError(failure.message)),
      (_) => emit(const OrderActionSuccess(message: 'Cập nhật trạng thái đơn hàng thành công!')),
    );
  }
}
