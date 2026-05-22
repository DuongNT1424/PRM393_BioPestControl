import 'package:equatable/equatable.dart';

/// [OrderItemEntity] đại diện cho một sản phẩm cụ thể nằm trong đơn hàng.
class OrderItemEntity extends Equatable {
  final int productId;
  final String productName;
  final String sku;
  final String? imageUrl;
  final double price;
  final int quantity;

  const OrderItemEntity({
    required this.productId,
    required this.productName,
    required this.sku,
    this.imageUrl,
    required this.price,
    required this.quantity,
  });

  @override
  List<Object?> get props => [productId, productName, sku, imageUrl, price, quantity];
}

/// [OrderEntity] là thực thể cốt lõi đại diện cho một đơn hàng trong hệ thống.
class OrderEntity extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String shippingAddress;
  final List<OrderItemEntity> items;
  final double totalAmount;
  final String paymentMethod; // "COD" hoặc "PayOS"
  final String paymentStatus; // "Pending" (Chờ thanh toán), "Paid" (Đã thanh toán), "Failed" (Thất bại)
  final String deliveryStatus; // "Pending" (Chờ xác nhận), "Preparing" (Chuẩn bị), "Delivering" (Đang giao), "Delivered" (Đã giao), "Cancelled" (Đã hủy)
  final DateTime createdAt;

  const OrderEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.shippingAddress,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryStatus,
    required this.createdAt,
  });

  /// Tạo một bản sao mới với một vài thuộc tính thay đổi (dùng khi cập nhật trạng thái)
  OrderEntity copyWith({
    String? id,
    String? customerId,
    String? customerName,
    String? customerPhone,
    String? shippingAddress,
    List<OrderItemEntity>? items,
    double? totalAmount,
    String? paymentMethod,
    String? paymentStatus,
    String? deliveryStatus,
    DateTime? createdAt,
  }) {
    return OrderEntity(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      shippingAddress: shippingAddress ?? this.shippingAddress,
      items: items ?? this.items,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      deliveryStatus: deliveryStatus ?? this.deliveryStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        customerPhone,
        shippingAddress,
        items,
        totalAmount,
        paymentMethod,
        paymentStatus,
        deliveryStatus,
        createdAt,
      ];
}
