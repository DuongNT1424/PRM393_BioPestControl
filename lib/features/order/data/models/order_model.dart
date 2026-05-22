import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/order.dart';

/// [OrderItemModel] phục vụ ánh xạ dữ liệu sản phẩm trong đơn hàng ở tầng Data.
class OrderItemModel extends OrderItemEntity {
  const OrderItemModel({
    required super.productId,
    required super.productName,
    required super.sku,
    super.imageUrl,
    required super.price,
    required super.quantity,
  });

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['productId'] ?? 0,
      productName: map['productName'] ?? '',
      sku: map['sku'] ?? '',
      imageUrl: map['imageUrl'],
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      quantity: map['quantity'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'sku': sku,
      'imageUrl': imageUrl,
      'price': price,
      'quantity': quantity,
    };
  }

  static OrderItemModel fromEntity(OrderItemEntity entity) {
    return OrderItemModel(
      productId: entity.productId,
      productName: entity.productName,
      sku: entity.sku,
      imageUrl: entity.imageUrl,
      price: entity.price,
      quantity: entity.quantity,
    );
  }
}

/// [OrderModel] phục vụ ánh xạ tài liệu Firestore của Đơn hàng ở tầng Data.
class OrderModel extends OrderEntity {
  const OrderModel({
    required super.id,
    required super.customerId,
    required super.customerName,
    required super.customerPhone,
    required super.shippingAddress,
    required super.items,
    required super.totalAmount,
    required super.paymentMethod,
    required super.paymentStatus,
    required super.deliveryStatus,
    required super.createdAt,
  });

  /// Chuyển đổi từ Firestore DocumentSnapshot sang [OrderModel]
  factory OrderModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final itemsList = (data['items'] as List<dynamic>?) ?? [];
    
    return OrderModel(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      customerPhone: data['customerPhone'] ?? '',
      shippingAddress: data['shippingAddress'] ?? '',
      items: itemsList.map((item) => OrderItemModel.fromMap(item as Map<String, dynamic>)).toList(),
      totalAmount: (data['totalAmount'] as num?)?.toDouble() ?? 0.0,
      paymentMethod: data['paymentMethod'] ?? 'COD',
      paymentStatus: data['paymentStatus'] ?? 'Pending',
      deliveryStatus: data['deliveryStatus'] ?? 'Pending',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Chuyển đổi sang Map JSON để đẩy lên Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'shippingAddress': shippingAddress,
      'items': items.map((item) => OrderItemModel.fromEntity(item).toMap()).toList(),
      'totalAmount': totalAmount,
      'paymentMethod': paymentMethod,
      'paymentStatus': paymentStatus,
      'deliveryStatus': deliveryStatus,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Chuyển đổi từ Thực thể Domain [OrderEntity] sang [OrderModel]
  static OrderModel fromEntity(OrderEntity entity) {
    return OrderModel(
      id: entity.id,
      customerId: entity.customerId,
      customerName: entity.customerName,
      customerPhone: entity.customerPhone,
      shippingAddress: entity.shippingAddress,
      items: entity.items,
      totalAmount: entity.totalAmount,
      paymentMethod: entity.paymentMethod,
      paymentStatus: entity.paymentStatus,
      deliveryStatus: entity.deliveryStatus,
      createdAt: entity.createdAt,
    );
  }
}
