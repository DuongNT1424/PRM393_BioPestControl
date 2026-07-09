import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chemical_entity.dart';
import '../../domain/repositories/chemical_repository.dart';
import '../datasources/chemical_remote_data_source.dart';
import '../models/chemical_model.dart';

class ChemicalRepositoryImpl implements ChemicalRepository {
  final ChemicalRemoteDataSource remoteDataSource;

  ChemicalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChemicalEntity>>> getChemicals() async {
    try {
      final result = await remoteDataSource.getChemicals();
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không thể tải danh sách hóa chất'));
    }
  }

  @override
  Future<Either<Failure, ChemicalEntity>> getChemicalById(String id) async {
    try {
      final result = await remoteDataSource.getChemicalById(id);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không tìm thấy hóa chất'));
    }
  }

  @override
  Future<Either<Failure, List<ChemicalEntity>>> searchChemicals(
      String query) async {
    try {
      final result = await remoteDataSource.searchChemicals(query);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi tìm kiếm hóa chất'));
    }
  }

  @override
  Future<Either<Failure, List<ChemicalEntity>>> filterChemicals({
    String? signalWord,
    bool? isBanned,
  }) async {
    try {
      final result = await remoteDataSource.filterChemicals(
        signalWord: signalWord,
        isBanned: isBanned,
      );
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi lọc hóa chất'));
    }
  }

  @override
  Future<Either<Failure, void>> createChemical(
      ChemicalEntity chemical) async {
    try {
      final model = ChemicalModel(
        commonName: chemical.commonName,
        casNumber: chemical.casNumber,
        signalWord: chemical.signalWord,
        hazardStatement: chemical.hazardStatement,
        precautionaryStatement: chemical.precautionaryStatement,
        firstAidMeasures: chemical.firstAidMeasures,
        hazardSymbol: chemical.hazardSymbol,
        isBanned: chemical.isBanned,
        createdById: chemical.createdById,
        createdByName: chemical.createdByName,
      );
      await remoteDataSource.createChemical(model);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể tạo hóa chất mới'));
    }
  }

  @override
  Future<Either<Failure, void>> updateChemical(
      ChemicalEntity chemical) async {
    try {
      final model = ChemicalModel(
        id: chemical.id,
        commonName: chemical.commonName,
        casNumber: chemical.casNumber,
        signalWord: chemical.signalWord,
        hazardStatement: chemical.hazardStatement,
        precautionaryStatement: chemical.precautionaryStatement,
        firstAidMeasures: chemical.firstAidMeasures,
        hazardSymbol: chemical.hazardSymbol,
        isBanned: chemical.isBanned,
        createdById: chemical.createdById,
        createdByName: chemical.createdByName,
        createdAt: chemical.createdAt,
      );
      await remoteDataSource.updateChemical(model);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể cập nhật hóa chất'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteChemical(String id) async {
    try {
      await remoteDataSource.deleteChemical(id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể xóa hóa chất'));
    }
  }
}
