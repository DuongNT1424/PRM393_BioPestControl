import 'package:equatable/equatable.dart';

/// [ProductEntity] đại diện cho một sản phẩm trong hệ thống BioPest.
class ProductEntity extends Equatable {
  final int? id;
  final String sku;
  final String name;
  final String? description;
  final double price;
  final int stock;
  final int categoryId;
  final bool isActive;
  final String? imageUrl;

  const ProductEntity({
    this.id,
    required this.sku,
    required this.name,
    this.description,
    required this.price,
    required this.stock,
    required this.categoryId,
    this.isActive = true,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, sku, name, description, price, stock, categoryId, isActive, imageUrl];
}
