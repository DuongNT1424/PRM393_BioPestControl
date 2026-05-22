import 'package:equatable/equatable.dart';
import '../../domain/entities/order.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object?> get props => [];
}

/// Sự kiện tạo đơn hàng mới
class CreateOrderEvent extends OrderEvent {
  final OrderEntity order;

  const CreateOrderEvent(this.order);

  @override
  List<Object?> get props => [order];
}

/// Sự kiện tải danh sách đơn hàng (hỗ trợ lọc/tìm kiếm)
class LoadOrdersEvent extends OrderEvent {
  final String? customerId;
  final String? deliveryStatus;
  final String? searchQuery;

  const LoadOrdersEvent({
    this.customerId,
    this.deliveryStatus,
    this.searchQuery,
  });

  @override
  List<Object?> get props => [customerId, deliveryStatus, searchQuery];
}

/// Sự kiện tải chi tiết một đơn hàng cụ thể
class LoadOrderDetailEvent extends OrderEvent {
  final String orderId;

  const LoadOrderDetailEvent(this.orderId);

  @override
  List<Object?> get props => [orderId];
}

/// Sự kiện cập nhật trạng thái đơn hàng (giao hàng / thanh toán)
class UpdateOrderStatusEvent extends OrderEvent {
  final String orderId;
  final String deliveryStatus;
  final String? paymentStatus;

  const UpdateOrderStatusEvent({
    required this.orderId,
    required this.deliveryStatus,
    this.paymentStatus,
  });

  @override
  List<Object?> get props => [orderId, deliveryStatus, paymentStatus];
}
