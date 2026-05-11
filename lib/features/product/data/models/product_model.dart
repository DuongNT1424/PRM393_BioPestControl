import '../../domain/entities/product_entity.dart';

/// [ProductModel] dùng để chuyển đổi dữ liệu giữa SQLite và Entity.
class ProductModel extends ProductEntity {
  const ProductModel({
    super.id,
    required super.sku,
    required super.name,
    super.description,
    required super.price,
    required super.stock,
    required super.categoryId,
    super.isActive,
    super.imageUrl,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'],
      sku: map['sku'],
      name: map['name'],
      description: map['description'],
      price: (map['price'] as num).toDouble(),
      stock: map['stock'],
      categoryId: map['category_id'],
      isActive: map['is_active'] == 1,
      imageUrl: map['image_url'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sku': sku,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'category_id': categoryId,
      'is_active': isActive ? 1 : 0,
      'image_url': imageUrl,
    };
  }
}
