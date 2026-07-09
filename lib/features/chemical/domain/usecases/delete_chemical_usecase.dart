import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chemical_repository.dart';

class DeleteChemicalUseCase {
  final ChemicalRepository repository;

  DeleteChemicalUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteChemical(id);
  }
}
