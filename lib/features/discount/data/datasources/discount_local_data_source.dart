import '../../../../core/database/database_helper.dart';
import '../models/discount_model.dart';

/// [DiscountLocalDataSource] định nghĩa các thao tác trực tiếp với SQLite cho tính năng Giảm giá.
abstract class DiscountLocalDataSource {
  /// Lấy danh sách giảm giá kèm theo tên sản phẩm (dùng JOIN/Subquery).
  Future<List<DiscountModel>> getDiscounts();

  /// Lấy chi tiết một mã giảm giá kèm danh sách sản phẩm liên kết.
  Future<DiscountModel> getDiscountById(int id);

  /// Thêm mới giảm giá và lưu liên kết sản phẩm vào bảng trung gian.
  Future<void> addDiscount(DiscountModel discount);

  /// Cập nhật thông tin giảm giá và làm mới bảng liên kết sản phẩm.
  Future<void> updateDiscount(DiscountModel discount);

  /// Xóa giảm giá (sẽ tự động xóa liên kết nhờ ON DELETE CASCADE).
  Future<void> deleteDiscount(int id);

  /// Tìm kiếm theo tên giảm giá hoặc tên sản phẩm.
  Future<List<DiscountModel>> searchDiscounts(String query);

  /// Lọc theo trạng thái.
  Future<List<DiscountModel>> filterDiscounts({bool? isActive});
}

/// [DiscountLocalDataSourceImpl] thực thi các truy vấn SQL.
class DiscountLocalDataSourceImpl implements DiscountLocalDataSource {
  final DatabaseHelper dbHelper;

  DiscountLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<DiscountModel>> getDiscounts() async {
    final db = await dbHelper.database;
    // Lấy tất cả giảm giá
    final List<Map<String, dynamic>> discountMaps = await db.rawQuery('''
      SELECT d.*, 
             (SELECT GROUP_CONCAT(p.name, ', ') 
              FROM discount_products dp 
              JOIN products p ON dp.product_id = p.id 
              WHERE dp.discount_id = d.id) as product_names
      FROM discounts d
      ORDER BY d.id DESC
    ''');

    List<DiscountModel> results = [];
    for (var map in discountMaps) {
      final int discountId = map['id'];
      // Lấy danh sách ID sản phẩm liên kết
      final List<Map<String, dynamic>> productIdsMaps = await db.query(
        'discount_products',
        columns: ['product_id'],
        where: 'discount_id = ?',
        whereArgs: [discountId],
      );
      final productIds = productIdsMaps.map((m) => m['product_id'] as int).toList();
      results.add(DiscountModel.fromMap(map, productIds: productIds));
    }
    return results;
  }

  @override
  Future<DiscountModel> getDiscountById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT d.*, 
             (SELECT GROUP_CONCAT(p.name, ', ') 
              FROM discount_products dp 
              JOIN products p ON dp.product_id = p.id 
              WHERE dp.discount_id = d.id) as product_names
      FROM discounts d
      WHERE d.id = ?
    ''', [id]);
    
    if (maps.isNotEmpty) {
      final List<Map<String, dynamic>> productIdsMaps = await db.query(
        'discount_products',
        columns: ['product_id'],
        where: 'discount_id = ?',
        whereArgs: [id],
      );
      final productIds = productIdsMaps.map((m) => m['product_id'] as int).toList();
      return DiscountModel.fromMap(maps.first, productIds: productIds);
    } else {
      throw Exception('Discount not found');
    }
  }

  @override
  Future<void> addDiscount(DiscountModel discount) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      // 1. Chèn thông tin giảm giá chính
      final id = await txn.insert('discounts', discount.toMap());
      
      // 2. Chèn các liên kết sản phẩm (nếu không phải áp dụng cho tất cả)
      if (!discount.isAllProducts) {
        for (var productId in discount.productIds) {
          await txn.insert('discount_products', {
            'discount_id': id,
            'product_id': productId,
          });
        }
      }
    });
  }

  @override
  Future<void> updateDiscount(DiscountModel discount) async {
    final db = await dbHelper.database;
    await db.transaction((txn) async {
      // 1. Cập nhật thông tin chính
      await txn.update(
        'discounts',
        discount.toMap(),
        where: 'id = ?',
        whereArgs: [discount.id],
      );
      
      // 2. Xóa các liên kết cũ
      await txn.delete('discount_products', where: 'discount_id = ?', whereArgs: [discount.id]);
      
      // 3. Chèn các liên kết mới (nếu không phải áp dụng cho tất cả)
      if (!discount.isAllProducts) {
        for (var productId in discount.productIds) {
          await txn.insert('discount_products', {
            'discount_id': discount.id,
            'product_id': productId,
          });
        }
      }
    });
  }

  @override
  Future<void> deleteDiscount(int id) async {
    final db = await dbHelper.database;
    await db.delete('discounts', where: 'id = ?', whereArgs: [id]);
  }

  @override
  Future<List<DiscountModel>> searchDiscounts(String query) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> discountMaps = await db.rawQuery('''
      SELECT d.*, 
             (SELECT GROUP_CONCAT(p.name, ', ') 
              FROM discount_products dp 
              JOIN products p ON dp.product_id = p.id 
              WHERE dp.discount_id = d.id) as product_names
      FROM discounts d
      WHERE d.name LIKE ? OR product_names LIKE ?
    ''', ['%$query%', '%$query%']);

    List<DiscountModel> results = [];
    for (var map in discountMaps) {
      final int discountId = map['id'];
      final List<Map<String, dynamic>> productIdsMaps = await db.query(
        'discount_products',
        columns: ['product_id'],
        where: 'discount_id = ?',
        whereArgs: [discountId],
      );
      final productIds = productIdsMaps.map((m) => m['product_id'] as int).toList();
      results.add(DiscountModel.fromMap(map, productIds: productIds));
    }
    return results;
  }

  @override
  Future<List<DiscountModel>> filterDiscounts({bool? isActive}) async {
    final db = await dbHelper.database;
    String sql = '''
      SELECT d.*, 
             (SELECT GROUP_CONCAT(p.name, ', ') 
              FROM discount_products dp 
              JOIN products p ON dp.product_id = p.id 
              WHERE dp.discount_id = d.id) as product_names
      FROM discounts d
    ''';
    List<dynamic> args = [];
    
    if (isActive != null) {
      sql += ' WHERE d.is_active = ?';
      args.add(isActive ? 1 : 0);
    }
    
    final List<Map<String, dynamic>> discountMaps = await db.rawQuery(sql, args);
    List<DiscountModel> results = [];
    for (var map in discountMaps) {
      final int discountId = map['id'];
      final List<Map<String, dynamic>> productIdsMaps = await db.query(
        'discount_products',
        columns: ['product_id'],
        where: 'discount_id = ?',
        whereArgs: [discountId],
      );
      final productIds = productIdsMaps.map((m) => m['product_id'] as int).toList();
      results.add(DiscountModel.fromMap(map, productIds: productIds));
    }
    return results;
  }
}
