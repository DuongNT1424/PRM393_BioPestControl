import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/order_model.dart';

abstract class OrderRemoteDataSource {
  Future<String> createOrder(OrderModel order);
  Future<List<OrderModel>> getOrders({String? customerId, String? deliveryStatus, String? searchQuery});
  Future<OrderModel> getOrderDetail(String orderId);
  Future<void> updateOrderStatus(String orderId, String deliveryStatus, {String? paymentStatus});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final FirebaseFirestore firestore;

  OrderRemoteDataSourceImpl({required this.firestore});

  @override
  Future<String> createOrder(OrderModel order) async {
    // Thêm bản ghi mới lên Firestore
    final docRef = await firestore.collection('orders').add(order.toFirestore());
    return docRef.id;
  }

  @override
  Future<List<OrderModel>> getOrders({
    String? customerId,
    String? deliveryStatus,
    String? searchQuery,
  }) async {
    Query query = firestore.collection('orders');

    // Lọc theo Customer ID (dành cho vai trò Khách hàng)
    if (customerId != null && customerId.isNotEmpty) {
      query = query.where('customerId', isEqualTo: customerId);
    }

    // Lọc theo trạng thái giao hàng
    if (deliveryStatus != null && deliveryStatus.isNotEmpty) {
      query = query.where('deliveryStatus', isEqualTo: deliveryStatus);
    }

    final snapshot = await query.get();
    
    // Ánh xạ tài liệu thành lớp OrderModel
    List<OrderModel> orders = snapshot.docs.map((doc) => OrderModel.fromFirestore(doc)).toList();

    // Sắp xếp theo ngày đặt mới nhất lên đầu trên bộ nhớ để tránh yêu cầu tạo Composite Index thủ công trên Firestore console
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    // Hỗ trợ tìm kiếm từ khóa trên bộ nhớ (Search in memory) để tối ưu truy vấn Firestore phức tạp
    if (searchQuery != null && searchQuery.isNotEmpty) {
      final queryLower = searchQuery.toLowerCase();
      orders = orders.where((order) {
        // Tìm kiếm theo ID đơn hàng
        final matchId = order.id.toLowerCase().contains(queryLower);
        // Tìm kiếm theo tên khách hàng
        final matchName = order.customerName.toLowerCase().contains(queryLower);
        // Tìm kiếm theo tên bất kỳ sản phẩm nào có trong đơn hàng
        final matchItemName = order.items.any((item) => item.productName.toLowerCase().contains(queryLower));
        
        return matchId || matchName || matchItemName;
      }).toList();
    }

    return orders;
  }

  @override
  Future<OrderModel> getOrderDetail(String orderId) async {
    final doc = await firestore.collection('orders').doc(orderId).get();
    if (!doc.exists) {
      throw Exception('Không tìm thấy đơn hàng trong hệ thống.');
    }
    return OrderModel.fromFirestore(doc);
  }

  @override
  Future<void> updateOrderStatus(
    String orderId,
    String deliveryStatus, {
    String? paymentStatus,
  }) async {
    final Map<String, dynamic> updateData = {
      'deliveryStatus': deliveryStatus,
    };
    
    if (paymentStatus != null) {
      updateData['paymentStatus'] = paymentStatus;
    }

    await firestore.collection('orders').doc(orderId).update(updateData);
  }
}
