import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/repositories/category_repository.dart';
import '../datasources/category_local_data_source.dart';
import '../models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryLocalDataSource localDataSource;

  CategoryRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<CategoryEntity>>> getCategories() async {
    try {
      final categories = await localDataSource.getCategories();
      return Right<Failure, List<CategoryEntity>>(categories);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể tải danh sách danh mục'));
    }
  }

  @override
  Future<Either<Failure, void>> addCategory(CategoryEntity category) async {
    try {
      final model = CategoryModel(
        id: category.id,
        name: category.name,
        description: category.description,
      );
      await localDataSource.addCategory(model);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể thêm danh mục'));
    }
  }

  @override
  Future<Either<Failure, void>> updateCategory(CategoryEntity category) async {
    try {
      final model = CategoryModel(
        id: category.id,
        name: category.name,
        description: category.description,
      );
      await localDataSource.updateCategory(model);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể cập nhật danh mục'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCategory(int id) async {
    try {
      await localDataSource.deleteCategory(id);
      return const Right(null);
    } catch (e) {
      return const Left(DatabaseFailure('Không thể xóa danh mục'));
    }
  }
}
