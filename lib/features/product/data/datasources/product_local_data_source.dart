import '../../../../core/database/database_helper.dart';
import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getProducts();
  Future<List<ProductModel>> searchProducts(String query);
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
