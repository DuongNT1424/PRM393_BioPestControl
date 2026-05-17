import '../../domain/entities/discount_entity.dart';

/// [DiscountModel] là lớp kế thừa từ [DiscountEntity] để xử lý chuyển đổi dữ liệu.
/// Lớp này chịu trách nhiệm map dữ liệu từ/vào SQLite (Map<String, dynamic>).
class DiscountModel extends DiscountEntity {
  const DiscountModel({
    super.id,
    required super.name,
    super.description,
    required super.discountPercent,
    required super.startDate,
    required super.endDate,
    super.productIds = const [],
    super.isAllProducts = false,
    super.isActive,
    super.productNames,
  });

  /// Chuyển đổi dữ liệu từ Map (SQLite) sang Object.
  factory DiscountModel.fromMap(Map<String, dynamic> map, {List<int> productIds = const []}) {
    return DiscountModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      discountPercent: map['discount_percent'] as double,
      startDate: DateTime.parse(map['start_date']),
      endDate: DateTime.parse(map['end_date']),
      isAllProducts: map['is_all_products'] == 1,
      isActive: map['is_active'] == 1,
      productIds: productIds,
      productNames: map['product_names'], 
    );
  }

  /// Chuyển đổi từ Object sang Map để lưu vào SQLite.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'discount_percent': discountPercent,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'is_all_products': isAllProducts ? 1 : 0,
      'is_active': isActive ? 1 : 0,
    };
  }

  /// Chuyển đổi từ Entity (Domain) sang Model (Data).
  factory DiscountModel.fromEntity(DiscountEntity entity) {
    return DiscountModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      discountPercent: entity.discountPercent,
      startDate: entity.startDate,
      endDate: entity.endDate,
      productIds: entity.productIds,
      isAllProducts: entity.isAllProducts,
      isActive: entity.isActive,
      productNames: entity.productNames,
    );
  }

  DiscountEntity toEntity() {
    return DiscountEntity(
      id: id,
      name: name,
      description: description,
      discountPercent: discountPercent,
      startDate: startDate,
      endDate: endDate,
      productIds: productIds,
      isAllProducts: isAllProducts,
      isActive: isActive,
      productNames: productNames,
    );
  }
}
