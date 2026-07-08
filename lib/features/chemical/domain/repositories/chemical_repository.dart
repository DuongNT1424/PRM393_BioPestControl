import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chemical_entity.dart';

abstract class ChemicalRepository {
  Future<Either<Failure, List<ChemicalEntity>>> getChemicals();

  Future<Either<Failure, ChemicalEntity>> getChemicalById(String id);

  Future<Either<Failure, List<ChemicalEntity>>> searchChemicals(String query);

  Future<Either<Failure, List<ChemicalEntity>>> filterChemicals({
    String? signalWord,
    bool? isBanned,
  });

  Future<Either<Failure, void>> createChemical(ChemicalEntity chemical);

  Future<Either<Failure, void>> updateChemical(ChemicalEntity chemical);

  Future<Either<Failure, void>> deleteChemical(String id);
}
