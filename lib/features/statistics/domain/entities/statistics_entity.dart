import 'package:equatable/equatable.dart';

/// [StatisticsEntity] đại diện cho bộ dữ liệu thống kê của hệ thống.
class StatisticsEntity extends Equatable {
  /// Tổng doanh thu (VNĐ).
  final double totalRevenue;
  
  /// Tổng số lượng sản phẩm đã bán.
  final int totalSold;
  
  /// Tổng số sản phẩm đang liên kết/hoạt động trong hệ thống.
  final int totalLinkedProducts;
  
  /// Số lượng đơn hàng mới (Dành cho Dashboard).
  final int newOrders;

  /// Doanh thu theo thứ trong tuần (0: Thứ 2 -> 6: Chủ Nhật)
  final List<double> revenueByWeekday;

  const StatisticsEntity({
    required this.totalRevenue,
    required this.totalSold,
    required this.totalLinkedProducts,
    required this.newOrders,
    required this.revenueByWeekday,
  });

  @override
  List<Object?> get props => [totalRevenue, totalSold, totalLinkedProducts, newOrders, revenueByWeekday];
}
