import '../../../../core/database/database_helper.dart';
import '../models/category_model.dart';

abstract class CategoryLocalDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<void> addCategory(CategoryModel category);
  Future<void> updateCategory(CategoryModel category);
  Future<void> deleteCategory(int id);
}

class CategoryLocalDataSourceImpl implements CategoryLocalDataSource {
  final DatabaseHelper dbHelper;

  CategoryLocalDataSourceImpl({required this.dbHelper});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final db = await dbHelper.database;
    final List<Map<String, dynamic>> maps = await db.query('categories');
    return maps.map((map) => CategoryModel.fromMap(map)).toList();
  }

  @override
  Future<void> addCategory(CategoryModel category) async {
    final db = await dbHelper.database;
    await db.insert('categories', category.toMap());
  }

  @override
  Future<void> updateCategory(CategoryModel category) async {
    final db = await dbHelper.database;
    await db.update(
      'categories',
      category.toMap(),
      where: 'id = ?',
      whereArgs: [category.id],
    );
  }

  @override
  Future<void> deleteCategory(int id) async {
    final db = await dbHelper.database;
    await db.delete('categories', where: 'id = ?', whereArgs: [id]);
  }
}
