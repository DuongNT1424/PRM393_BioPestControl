import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/place.dart';
import '../repositories/map_repository.dart';

class SearchLocationUseCase {
  final MapRepository repository;

  SearchLocationUseCase(this.repository);

  Future<Either<Failure, List<PlaceEntity>>> call(String query) {
    return repository.searchLocation(query);
  }
}
