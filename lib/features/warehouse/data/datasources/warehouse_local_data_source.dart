import 'package:prm393_biopestcontrol/core/database/database_helper.dart';
import 'package:prm393_biopestcontrol/features/warehouse/data/models/warehouse_model.dart';
import 'package:prm393_biopestcontrol/features/warehouse/data/models/warehouse_inventory_model.dart';
import 'package:prm393_biopestcontrol/features/product/data/models/product_model.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';

/// [WarehouseLocalDataSource] quản lý truy vấn SQLite cho tính năng Kho.
abstract class WarehouseLocalDataSource {
  /// Lấy danh sách kho từ DB.
  Future<List<WarehouseModel>> getWarehouses();
  
  /// Lấy tồn kho theo warehouseId.
  Future<List<WarehouseInventoryModel>> getInventory(int warehouseId);
  
  /// Tìm kiếm tồn kho.
  Future<List<WarehouseInventoryModel>> searchInventory(String query);
  
  /// Nhập hàng loạt vào kho.
  Future<void> importProducts(int warehouseId, List<ImportItem> items);
}

class WarehouseLocalDataSourceImpl implements WarehouseLocalDataSource {
  final DatabaseHelper dbHelper;

  WarehouseLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<WarehouseModel>> getWarehouses() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('warehouses');
    return maps.map((map) => WarehouseModel.fromMap(map)).toList();
  }

  @override
  Future<List<WarehouseInventoryModel>> getInventory(int warehouseId) async {
    final db = await dbHelper.database;
    
    // Join với bảng products để lấy thông tin sản phẩm chi tiết
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT wi.*, p.name as p_name, p.sku as p_sku, p.price as p_price, p.image_url as p_image_url
      FROM warehouse_inventory wi
      JOIN products p ON wi.product_id = p.id
      WHERE wi.warehouse_id = ?
    ''', [warehouseId]);

    return _mapInventoryResults(maps);
  }

  @override
  Future<List<WarehouseInventoryModel>> searchInventory(String query) async {
    final db = await dbHelper.database;
    
    // Tìm kiếm sản phẩm trong kho dựa trên tên hoặc mã SKU
    final List<Map<String, dynamic>> maps = await db.rawQuery('''
      SELECT wi.*, p.name as p_name, p.sku as p_sku, p.price as p_price, p.image_url as p_image_url
      FROM warehouse_inventory wi
      JOIN products p ON wi.product_id = p.id
      WHERE p.name LIKE ? OR p.sku LIKE ?
    ''', ['%$query%', '%$query%']);

    return _mapInventoryResults(maps);
  }

  @override
  Future<void> importProducts(int warehouseId, List<ImportItem> items) async {
    final db = await dbHelper.database;
    
    // Sử dụng transaction để đảm bảo tất cả sản phẩm đều được nhập thành công hoặc không gì cả
    await db.transaction((txn) async {
      for (var item in items) {
        // 1. Cập nhật tồn kho của từng Kho (Warehouse Inventory)
        final List<Map<String, dynamic>> existing = await txn.query(
          'warehouse_inventory',
          where: 'warehouse_id = ? AND product_id = ?',
          whereArgs: [warehouseId, item.productId],
        );

        if (existing.isNotEmpty) {
          final int currentQty = existing.first['quantity'];
          await txn.update(
            'warehouse_inventory',
            {'quantity': currentQty + item.quantity},
            where: 'warehouse_id = ? AND product_id = ?',
            whereArgs: [warehouseId, item.productId],
          );
        } else {
          await txn.insert('warehouse_inventory', {
            'warehouse_id': warehouseId,
            'product_id': item.productId,
            'quantity': item.quantity,
          });
        }

        // 2. Cập nhật tổng tồn kho toàn hệ thống trong bảng Products
        final List<Map<String, dynamic>> productResult = await txn.query(
          'products',
          where: 'id = ?',
          whereArgs: [item.productId],
        );
        if (productResult.isNotEmpty) {
          final int currentProductStock = productResult.first['stock'];
          await txn.update(
            'products',
            {'stock': currentProductStock + item.quantity},
            where: 'id = ?',
            whereArgs: [item.productId],
          );
        }
      }
    });
  }

  /// Chuyển đổi kết quả từ SQL Map sang WarehouseInventoryModel
  List<WarehouseInventoryModel> _mapInventoryResults(List<Map<String, dynamic>> maps) {
    return maps.map((map) {
      final productMap = {
        'id': map['product_id'],
        'name': map['p_name'],
        'sku': map['p_sku'],
        'price': map['p_price'],
        'image_url': map['p_image_url'],
        'stock': map['quantity'], 
        'category_id': 0, 
      };
      
      return WarehouseInventoryModel(
        warehouseId: map['warehouse_id'],
        productId: map['product_id'],
        quantity: map['quantity'],
        product: ProductModel.fromMap(productMap),
      );
    }).toList();
  }
}
