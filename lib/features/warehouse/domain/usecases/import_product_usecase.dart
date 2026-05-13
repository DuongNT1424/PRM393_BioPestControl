import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/repositories/warehouse_repository.dart';

/// [ImportProductUseCase] thực hiện nghiệp vụ nhập hàng vào kho.
/// Chấp nhận danh sách các sản phẩm và số lượng tương ứng.
class ImportProductUseCase implements UseCase<void, ImportProductParams> {
  final WarehouseRepository repository;

  ImportProductUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ImportProductParams params) async {
    // Gọi repository để thực hiện nhập kho hàng loạt
    return await repository.importProducts(params.warehouseId, params.items);
  }
}

/// [ImportProductParams] chứa thông tin cần thiết để nhập hàng.
class ImportProductParams extends Equatable {
  final int warehouseId;
  /// Danh sách các cặp {productId: quantity}
  final List<ImportItem> items;

  const ImportProductParams({
    required this.warehouseId,
    required this.items,
  });

  @override
  List<Object?> get props => [warehouseId, items];
}

/// [ImportItem] đại diện cho một mục hàng được nhập.
class ImportItem extends Equatable {
  final int productId;
  final int quantity;

  const ImportItem({required this.productId, required this.quantity});

  @override
  List<Object?> get props => [productId, quantity];
}
