import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/repositories/warehouse_repository.dart';
import 'package:prm393_biopestcontrol/features/warehouse/data/datasources/warehouse_local_data_source.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';

/// [WarehouseRepositoryImpl] thực thi các phương thức của WarehouseRepository.
class WarehouseRepositoryImpl implements WarehouseRepository {
  final WarehouseLocalDataSource localDataSource;

  WarehouseRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<WarehouseEntity>>> getWarehouses() async {
    try {
      final results = await localDataSource.getWarehouses();
      return Right(results);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi lấy danh sách kho: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WarehouseInventoryEntity>>> getInventory(int warehouseId) async {
    try {
      final results = await localDataSource.getInventory(warehouseId);
      return Right(results);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi lấy tồn kho: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<WarehouseInventoryEntity>>> searchInventory(String query) async {
    try {
      final results = await localDataSource.searchInventory(query);
      return Right(results);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi tìm kiếm tồn kho: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> importProducts(int warehouseId, List<ImportItem> items) async {
    try {
      await localDataSource.importProducts(warehouseId, items);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Lỗi khi nhập kho hàng loạt: ${e.toString()}'));
    }
  }
}
