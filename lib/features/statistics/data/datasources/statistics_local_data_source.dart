import 'package:sqflite/sqflite.dart';
import '../../../../core/database/database_helper.dart';
import '../../domain/entities/statistics_entity.dart';

abstract class StatisticsLocalDataSource {
  Future<StatisticsEntity> getStatistics(String filterType);
}

class StatisticsLocalDataSourceImpl implements StatisticsLocalDataSource {
  final DatabaseHelper dbHelper;

  StatisticsLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<StatisticsEntity> getStatistics(String filterType) async {
    final db = await dbHelper.database;
    
    // Tính toán khoảng thời gian dựa trên bộ lọc
    String dateFilter = "";
    DateTime now = DateTime.now();
    
    if (filterType == 'today') {
      dateFilter = "WHERE date(created_at) = date('now')";
    } else if (filterType == 'week') {
      dateFilter = "WHERE date(created_at) >= date('now', '-7 days')";
    } else if (filterType == 'month') {
      dateFilter = "WHERE date(created_at) >= date('now', '-30 days')";
    }

    // 1. Tính tổng doanh thu và tổng số lượng đã bán từ bảng orders
    final List<Map<String, dynamic>> orderStats = await db.rawQuery(
      'SELECT SUM(total_amount) as revenue, SUM(total_items) as sold, COUNT(id) as count FROM orders $dateFilter'
    );

    // 2. Tính tổng sản phẩm liên kết từ bảng products
    final List<Map<String, dynamic>> productStats = await db.rawQuery(
      'SELECT COUNT(id) as total FROM products WHERE is_linked = 1'
    );

    double totalRevenue = (orderStats[0]['revenue'] ?? 0).toDouble();
    int totalSold = orderStats[0]['sold'] ?? 0;
    int newOrders = orderStats[0]['count'] ?? 0;
    int totalLinkedProducts = productStats[0]['total'] ?? 0;

    return StatisticsEntity(
      totalRevenue: totalRevenue,
      totalSold: totalSold,
      totalLinkedProducts: totalLinkedProducts,
      newOrders: newOrders,
    );
  }
}
