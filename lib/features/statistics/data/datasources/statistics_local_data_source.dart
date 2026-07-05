import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/entities/statistics_entity.dart';

abstract class StatisticsLocalDataSource {
  Future<StatisticsEntity> getStatistics(String filterType);
}

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
    
    // 1. Tính toán thời gian bắt đầu (startDate) dựa trên filterType
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
      startDate = DateTime(2000);
    }

    // 2. Truy vấn đơn hàng từ Firebase Firestore có createdAt >= startDate
    final snapshot = await firestore
        .collection('orders')
        .where('createdAt', isGreaterThanOrEqualTo: Timestamp.fromDate(startDate))
        .get();

    double totalRevenue = 0.0;
    int totalSold = 0;
    int newOrders = 0;

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final deliveryStatus = data['deliveryStatus'] ?? 'Pending';
      
      newOrders++;

      if (deliveryStatus != 'Cancelled') {
        final totalAmount = (data['totalAmount'] as num?)?.toDouble() ?? 0.0;
        totalRevenue += totalAmount;

        final itemsList = (data['items'] as List<dynamic>?) ?? [];
        for (final item in itemsList) {
          if (item is Map<String, dynamic>) {
            final quantity = item['quantity'] ?? 0;
            totalSold += (quantity as num).toInt();
          }
        }
      }
    }

    // 3. Tính tổng sản phẩm đang hoạt động từ bảng products trong SQLite (sửa cột is_active)
    final List<Map<String, dynamic>> productStats = await db.rawQuery(
      'SELECT COUNT(id) as total FROM products WHERE is_active = 1'
    );

    int totalLinkedProducts = productStats[0]['total'] ?? 0;

    return StatisticsEntity(
      totalRevenue: totalRevenue,
      totalSold: totalSold,
      totalLinkedProducts: totalLinkedProducts,
      newOrders: newOrders,
    );
  }
}
