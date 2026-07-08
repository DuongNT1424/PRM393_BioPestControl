import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chemical_entity.dart';
import '../repositories/chemical_repository.dart';

class GetChemicalsUseCase implements UseCase<List<ChemicalEntity>, NoParams> {
  final ChemicalRepository repository;

  GetChemicalsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChemicalEntity>>> call(NoParams params) {
    return repository.getChemicals();
  }
}
