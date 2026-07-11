import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/map.dart';
import '../repositories/map_repository.dart';

class GetStoreLocationsUseCase
    implements UseCase<List<StoreLocationEntity>, NoParams> {
  final MapRepository repository;

  GetStoreLocationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StoreLocationEntity>>> call(NoParams params) {
    return repository.getStoreLocations();
  }
}
