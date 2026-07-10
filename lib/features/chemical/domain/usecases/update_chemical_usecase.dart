import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chemical_entity.dart';
import '../repositories/chemical_repository.dart';

class UpdateChemicalUseCase {
  final ChemicalRepository repository;

  UpdateChemicalUseCase(this.repository);

  Future<Either<Failure, void>> call(ChemicalEntity chemical) {
    return repository.updateChemical(chemical);
  }
}
