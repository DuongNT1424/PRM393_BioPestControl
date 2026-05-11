import '../../../../core/database/database_helper.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> getProductById(int id);
  Future<List<ProductModel>> searchProducts(String query);
  Future<List<ProductModel>> filterProducts({int? categoryId, bool? isActive});
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(int id);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final DatabaseHelper dbHelper;

  ProductLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<ProductModel>> getProducts() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<ProductModel> getProductById(int id) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return ProductModel.fromMap(maps.first);
    } else {
      throw Exception('Product not found');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'name LIKE ? OR sku LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
    );
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<List<ProductModel>> filterProducts({int? categoryId, bool? isActive}) async {
    final db = await dbHelper.database;
    String whereClause = '';
    List<dynamic> whereArgs = [];

    if (categoryId != null) {
      whereClause += 'category_id = ?';
      whereArgs.add(categoryId);
    }

    if (isActive != null) {
      if (whereClause.isNotEmpty) whereClause += ' AND ';
      whereClause += 'is_active = ?';
      whereArgs.add(isActive ? 1 : 0);
    }

    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: whereClause.isEmpty ? null : whereClause,
      whereArgs: whereArgs.isEmpty ? null : whereArgs,
    );
    return maps.map((map) => ProductModel.fromMap(map)).toList();
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    final db = await dbHelper.database;
    await db.insert('products', product.toMap());
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final db = await dbHelper.database;
    await db.update(
      'products',
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    final db = await dbHelper.database;
    await db.delete('products', where: 'id = ?', whereArgs: [id]);
  }
}
