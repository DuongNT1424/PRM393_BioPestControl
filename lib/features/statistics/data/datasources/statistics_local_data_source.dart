import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/entities/statistics_entity.dart';

abstract class StatisticsLocalDataSource {
  Future<StatisticsEntity> getStatistics(String filterType);
}

/// [StatisticsLocalDataSourceImpl] Tầng DataSource tương tác trực tiếp với các nguồn dữ liệu.
/// Ở chức năng Quản lý Doanh thu này, nguồn dữ liệu là sự kết hợp của:
/// - Firebase Firestore (chứa dữ liệu Đơn hàng/Orders để tính doanh thu)
/// - SQLite nội bộ (chứa dữ liệu Sản phẩm/Products)
class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final DatabaseHelper dbHelper;
  final FirebaseFirestore firestore;

  StatisticsLocalDataSourceImpl({
    required this.dbHelper,
    required this.firestore,
  });

  @override
  Future<StatisticsEntity> getStatistics(String filterType) async {
    final db = await dbHelper.database;
    
    // 1. Thiết lập mốc thời gian (startDate) dựa vào bộ lọc (Hôm nay, Tuần này, Tháng này)
    final now = DateTime.now();
    DateTime startDate;
    if (filterType == 'today') {
      startDate = DateTime(now.year, now.month, now.day);
    } else if (filterType == 'week') {
      final sevenDaysAgo = now.subtract(const Duration(days: 7));
      startDate = DateTime(sevenDaysAgo.year, sevenDaysAgo.month, sevenDaysAgo.day);
    } else if (filterType == 'month') {
      final thirtyDaysAgo = now.subtract(const Duration(days: 30));
      startDate = DateTime(thirtyDaysAgo.year, thirtyDaysAgo.month, thirtyDaysAgo.day);
    } else {
      startDate = DateTime(2000); // Mặc định lấy từ rất lâu về trước (All time)
    }

    // 2. Truy vấn đơn hàng từ Firebase Firestore có thời gian tạo >= startDate
    final snapshot = await firestore
        .collection('orders')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    // Khởi tạo các biến chứa kết quả thống kê
    double totalRevenue = 0.0;
    int totalSold = 0;
    int newOrders = 0;
    List<double> revenueByWeekday = List.filled(7, 0.0);

    // Duyệt qua danh sách đơn hàng lấy được từ Firebase
    for (final doc in snapshot.docs) {
      final data = doc.data();
      final deliveryStatus = data['deliveryStatus'] ?? 'Pending';
      
      newOrders++;

      // Chỉ tính doanh thu và số lượng cho các đơn hàng chưa bị Hủy
      if (deliveryStatus != 'Cancelled') {
        final totalAmount = (data['totalAmount'] as num?)?.toDouble() ?? 0.0;
        totalRevenue += totalAmount; // Cộng dồn tổng doanh thu

        // Tính doanh thu theo ngày trong tuần để phục vụ cho việc vẽ biểu đồ
        final createdAtTimestamp = data['createdAt'] as Timestamp?;
        if (createdAtTimestamp != null) {
          final createdAt = createdAtTimestamp.toDate();
          final index = createdAt.weekday - 1; // DateTime.weekday: 1 (Mon) -> 7 (Sun)
          revenueByWeekday[index] += totalAmount;
        }

        // Lấy tổng số lượng sản phẩm bán ra từ mảng items trong đơn hàng
        final itemsList = (data['items'] as List<dynamic>?) ?? [];
        for (final item in itemsList) {
          if (item is Map<String, dynamic>) {
            final quantity = item['quantity'] ?? 0;
            totalSold += quantity as int;
          }
        }
      }
    }

    // 3. Tính tổng số sản phẩm đang hoạt động từ bảng products trong cơ sở dữ liệu SQLite cục bộ
    final List<Map<String, dynamic>> productStats = await db.rawQuery(
      'SELECT COUNT(id) as total FROM products WHERE is_active = 1'
    );

    int totalLinkedProducts = productStats[0]['total'] ?? 0;

    // 4. Đóng gói tất cả số liệu vào Entity và trả về cho Repository
    return StatisticsEntity(
      totalRevenue: totalRevenue,
      totalSold: totalSold,
      totalLinkedProducts: totalLinkedProducts,
      newOrders: newOrders,
      revenueByWeekday: revenueByWeekday,
    );
  }
}
