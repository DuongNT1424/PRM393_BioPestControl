import 'package:prm393_biopestcontrol/features/product/data/models/product_model.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';

class WarehouseInventoryModel extends WarehouseInventoryEntity {
  const WarehouseInventoryModel({
    required super.warehouseId,
    required super.productId,
    required super.quantity,
    super.product,
  });

  factory WarehouseInventoryModel.fromMap(Map<String, dynamic> map) {
    return WarehouseInventoryModel(
      warehouseId: map['warehouse_id'],
      productId: map['product_id'],
      quantity: map['quantity'],
      product: map['product'] != null ? ProductModel.fromMap(map['product']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'warehouse_id': warehouseId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
