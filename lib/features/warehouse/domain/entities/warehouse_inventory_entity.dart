import 'package:equatable/equatable.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';

class WarehouseInventoryEntity extends Equatable {
  final int warehouseId;
  final int productId;
  final int quantity;
  final ProductEntity? product; // Tùy chọn để hiển thị thông tin sản phẩm

  const WarehouseInventoryEntity({
    required this.warehouseId,
    required this.productId,
    required this.quantity,
    this.product,
  });

  @override
  List<Object?> get props => [warehouseId, productId, quantity, product];
}
