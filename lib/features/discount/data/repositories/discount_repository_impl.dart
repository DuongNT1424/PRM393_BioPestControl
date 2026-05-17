import '../../domain/entities/discount_entity.dart';
import '../../domain/repositories/discount_repository.dart';
import '../datasources/discount_local_data_source.dart';
import '../models/discount_model.dart';

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountLocalDataSource localDataSource;

  DiscountRepositoryImpl({required this.localDataSource});

  @override
  Future<List<DiscountEntity>> getDiscounts() async {
    final models = await localDataSource.getDiscounts();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<DiscountEntity> getDiscountById(int id) async {
    final model = await localDataSource.getDiscountById(id);
    return model.toEntity();
  }

  @override
  Future<void> addDiscount(DiscountEntity discount) async {
    final model = DiscountModel.fromEntity(discount);
    await localDataSource.addDiscount(model);
  }

  @override
  Future<void> updateDiscount(DiscountEntity discount) async {
    final model = DiscountModel.fromEntity(discount);
    await localDataSource.updateDiscount(model);
  }

  @override
  Future<void> deleteDiscount(int id) async {
    await localDataSource.deleteDiscount(id);
  }

  @override
  Future<List<DiscountEntity>> searchDiscounts(String query) async {
    final models = await localDataSource.searchDiscounts(query);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<DiscountEntity>> filterDiscounts({bool? isActive}) async {
    final models = await localDataSource.filterDiscounts(isActive: isActive);
    return models.map((model) => model.toEntity()).toList();
  }
}
