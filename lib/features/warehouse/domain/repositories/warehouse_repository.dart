import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';

/// [WarehouseRepository] định nghĩa các phương thức giao tiếp với dữ liệu Kho.
abstract class WarehouseRepository {
  /// Lấy danh sách tất cả các kho hàng.
  Future<Either<Failure, List<WarehouseEntity>>> getWarehouses();
  
  /// Lấy danh sách tồn kho của một kho cụ thể.
  Future<Either<Failure, List<WarehouseInventoryEntity>>> getInventory(int warehouseId);
  
  /// Tìm kiếm sản phẩm trong kho theo tên hoặc SKU.
  Future<Either<Failure, List<WarehouseInventoryEntity>>> searchInventory(String query);
  
  /// Nhập hàng loạt sản phẩm vào kho.
  Future<Either<Failure, void>> importProducts(int warehouseId, List<ImportItem> items);
}
