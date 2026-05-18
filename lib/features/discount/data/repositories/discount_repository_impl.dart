import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/discount_entity.dart';
import '../../domain/repositories/discount_repository.dart';
import '../datasources/discount_local_data_source.dart';
import '../models/discount_model.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountLocalDataSource localDataSource;

  DiscountRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<DiscountEntity>>> getDiscounts() async {
    try {
      final models = await localDataSource.getDiscounts();
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, DiscountEntity>> getDiscountById(int id) async {
    try {
      final model = await localDataSource.getDiscountById(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addDiscount(DiscountEntity discount) async {
    try {
      final model = DiscountModel.fromEntity(discount);
      await localDataSource.addDiscount(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateDiscount(DiscountEntity discount) async {
    try {
      final model = DiscountModel.fromEntity(discount);
      await localDataSource.updateDiscount(model);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteDiscount(int id) async {
    try {
      await localDataSource.deleteDiscount(id);
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DiscountEntity>>> searchDiscounts(String query) async {
    try {
      final models = await localDataSource.searchDiscounts(query);
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<DiscountEntity>>> filterDiscounts({bool? isActive}) async {
    try {
      final models = await localDataSource.filterDiscounts(isActive: isActive);
      return Right(models.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(DatabaseFailure(e.toString()));
    }
  }
}
