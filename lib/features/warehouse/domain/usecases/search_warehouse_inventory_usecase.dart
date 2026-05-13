import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/repositories/warehouse_repository.dart';

class SearchWarehouseInventoryUseCase implements UseCase<List<WarehouseInventoryEntity>, String> {
  final WarehouseRepository repository;

  SearchWarehouseInventoryUseCase(this.repository);

  @override
  Future<Either<Failure, List<WarehouseInventoryEntity>>> call(String query) async {
    return await repository.searchInventory(query);
  }
}
