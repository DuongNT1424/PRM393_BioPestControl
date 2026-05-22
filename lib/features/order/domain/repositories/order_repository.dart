import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/order.dart';

/// Hợp đồng quy định các nghiệp vụ về đơn hàng sẽ được triển khai ở tầng Data.
abstract class OrderRepository {
  /// Tạo đơn hàng mới, trả về ID của đơn hàng vừa tạo trên Firestore nếu thành công.
  Future<Either<Failure, String>> createOrder(OrderEntity order);

  /// Lấy danh sách đơn hàng. Hỗ trợ lọc theo customerId, trạng thái giao hàng, hoặc tìm kiếm từ khóa.
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    String? customerId,
    String? deliveryStatus,
    String? searchQuery,
  });

  /// Xem chi tiết một đơn hàng thông qua ID đơn hàng.
  Future<Either<Failure, OrderEntity>> getOrderDetail(String orderId);

  /// Cập nhật trạng thái giao hàng và/hoặc trạng thái thanh toán của đơn hàng.
  Future<Either<Failure, void>> updateOrderStatus(
    String orderId,
    String deliveryStatus, {
    String? paymentStatus,
  });
}
