import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/repositories/warehouse_repository.dart';

class GetWarehousesUseCase implements UseCase<List<WarehouseEntity>, NoParams> {
  final WarehouseRepository repository;

  GetWarehousesUseCase(this.repository);

  @override
  Future<Either<Failure, List<WarehouseEntity>>> call(NoParams params) async {
    return await repository.getWarehouses();
  }
}
