import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái ban đầu
class OrderInitial extends OrderState {}

/// Trạng thái đang tải dữ liệu / xử lý
class OrderLoading extends OrderState {}

/// Trạng thái thực hiện hành động thành công (Tạo mới hoặc cập nhật)
class OrderActionSuccess extends OrderState {
  final String? orderId; // Mã đơn hàng vừa tạo (nếu có)
  final String message;

  const OrderActionSuccess({this.orderId, required this.message});

  @override
  List<Object?> get props => [orderId, message];
}

/// Trạng thái tải danh sách đơn hàng thành công
class OrdersLoaded extends OrderState {
  final List<OrderEntity> orders;

  const OrdersLoaded(this.orders);

  @override
  List<Object?> get props => [orders];
}

/// Trạng thái tải chi tiết đơn hàng thành công
class OrderDetailLoaded extends OrderState {
  final OrderEntity order;

  const OrderDetailLoaded(this.order);

  @override
  List<Object?> get props => [order];
}

/// Trạng thái xảy ra lỗi
class OrderError extends OrderState {
  final String message;

  const OrderError(this.message);

  @override
  List<Object?> get props => [message];
}
