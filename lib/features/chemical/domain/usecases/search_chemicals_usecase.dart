import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chemical_entity.dart';
import '../repositories/chemical_repository.dart';

class SearchChemicalsUseCase {
  final ChemicalRepository repository;

  SearchChemicalsUseCase(this.repository);

  Future<Either<Failure, List<ChemicalEntity>>> call(String query) {
    return repository.searchChemicals(query);
  }
}
