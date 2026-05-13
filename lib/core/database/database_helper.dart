import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'seed_data.dart';

/// [DatabaseHelper] quản lý cơ sở dữ liệu SQLite của hệ thống BioPest Control.
/// 
/// Đã được tối ưu hóa từ file SQL Server gốc để phù hợp với môi trường Mobile.
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('biopest_v5.db'); // v4 to trigger re-creation with all 160 products
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  /// Khởi tạo các bảng đã được tối ưu hóa.
  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const textNullable = 'TEXT';
    const boolType = 'INTEGER NOT NULL DEFAULT 1';
    const integerType = 'INTEGER NOT NULL DEFAULT 0';
    const doubleType = 'REAL NOT NULL DEFAULT 0.0';

    // 1. Bảng Danh mục (Categories)
    await db.execute('''
      CREATE TABLE categories (
        id INTEGER PRIMARY KEY,
        name $textType,
        description $textNullable
      )
    ''');

    // 2. Bảng Sản phẩm (Products)
    await db.execute('''
      CREATE TABLE products (
        id $idType,
        sku $textType,
        name $textType,
        description $textNullable,
        price $doubleType,
        stock $integerType,
        category_id INTEGER NOT NULL,
        is_active $boolType,
        image_url $textNullable,
        FOREIGN KEY (category_id) REFERENCES categories (id)
      )
    ''');

    // 3. Bảng Đơn hàng (Orders)
    await db.execute('''
      CREATE TABLE orders (
        id $idType,
        order_date $textType,
        total_amount $doubleType,
        status $integerType,
        customer_id $integerType
      )
    ''');

    // 4. Bảng Chi tiết đơn hàng (Order Details)
    await db.execute('''
      CREATE TABLE order_details (
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity $integerType,
        unit_price $doubleType,
        PRIMARY KEY (order_id, product_id),
        FOREIGN KEY (order_id) REFERENCES orders (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    // 5. Bảng Kho hàng (Warehouses)
    await db.execute('''
      CREATE TABLE warehouses (
        id $idType,
        name $textType,
        address $textNullable
      )
    ''');

    // 6. Bảng Tồn kho theo kho (Warehouse Inventory)
    await db.execute('''
      CREATE TABLE warehouse_inventory (
        warehouse_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity $integerType,
        PRIMARY KEY (warehouse_id, product_id),
        FOREIGN KEY (warehouse_id) REFERENCES warehouses (id),
        FOREIGN KEY (product_id) REFERENCES products (id)
      )
    ''');

    // Nạp dữ liệu thật từ file seed_data.dart
    await seedDatabase(db);
    
    // Seed Warehouse data
    await _seedWarehouseData(db);
    
    // Thêm một số đơn hàng mẫu để Dashboard có số liệu
    await _seedSampleOrders(db);
  }

  Future<void> _seedSampleOrders(Database db) async {
    final now = DateTime.now().toIso8601String();
    // Chèn đơn hàng mẫu dựa trên một số sản phẩm đã seed (ví dụ ID 1 và 2)
    await db.insert('orders', {'id': 1, 'order_date': now, 'total_amount': 400000.0, 'status': 1, 'customer_id': 1});
    await db.insert('order_details', {'order_id': 1, 'product_id': 1, 'quantity': 1, 'unit_price': 180000.0});
    await db.insert('order_details', {'order_id': 1, 'product_id': 2, 'quantity': 1, 'unit_price': 220000.0});
  }

  Future<void> _seedWarehouseData(Database db) async {
    // 1. Chèn Kho mẫu
    await db.insert('warehouses', {'id': 1, 'name': 'Kho Tổng Hà Nội', 'address': 'Số 1, Đại Cồ Việt, Hà Nội'});
    await db.insert('warehouses', {'id': 2, 'name': 'Kho Chi Nhánh HCM', 'address': '123 Quận 1, TP. HCM'});

    // 2. Chèn Tồn kho mẫu cho các sản phẩm đã seed
    // Giả định các sản phẩm có ID từ 1 đến 5 đã tồn tại từ seedDatabase
    await db.insert('warehouse_inventory', {'warehouse_id': 1, 'product_id': 1, 'quantity': 100});
    await db.insert('warehouse_inventory', {'warehouse_id': 1, 'product_id': 2, 'quantity': 50});
    await db.insert('warehouse_inventory', {'warehouse_id': 2, 'product_id': 1, 'quantity': 30});
    await db.insert('warehouse_inventory', {'warehouse_id': 2, 'product_id': 3, 'quantity': 80});
  }
}
