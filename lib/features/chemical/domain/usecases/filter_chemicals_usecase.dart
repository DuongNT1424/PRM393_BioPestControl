import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chemical_entity.dart';
import '../repositories/chemical_repository.dart';

class FilterChemicalsParams {
  final String? signalWord;
  final bool? isBanned;

  const FilterChemicalsParams({this.signalWord, this.isBanned});
}

class FilterChemicalsUseCase {
  final ChemicalRepository repository;

  FilterChemicalsUseCase(this.repository);

  Future<Either<Failure, List<ChemicalEntity>>> call(
      FilterChemicalsParams params) {
    return repository.filterChemicals(
      signalWord: params.signalWord,
      isBanned: params.isBanned,
    );
  }
}
