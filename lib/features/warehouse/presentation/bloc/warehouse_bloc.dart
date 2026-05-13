import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/get_warehouses_usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/search_warehouse_inventory_usecase.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';

// --- Events ---

abstract class WarehouseEvent extends Equatable {
  const WarehouseEvent();
  @override
  List<Object?> get props => [];
}

/// Sự kiện tải danh sách kho và tồn kho ban đầu.
class LoadWarehousesEvent extends WarehouseEvent {}

/// Sự kiện tìm kiếm sản phẩm trong kho.
class SearchWarehouseInventoryEvent extends WarehouseEvent {
  final String query;
  const SearchWarehouseInventoryEvent(this.query);
  @override
  List<Object?> get props => [query];
}

/// Sự kiện nhập hàng loạt sản phẩm vào kho.
class ImportProductEvent extends WarehouseEvent {
  final int warehouseId;
  final List<ImportItem> items;
  const ImportProductEvent({
    required this.warehouseId,
    required this.items,
  });
  @override
  List<Object?> get props => [warehouseId, items];
}

// --- States ---

abstract class WarehouseState extends Equatable {
  const WarehouseState();
  @override
  List<Object?> get props => [];
}

class WarehouseInitial extends WarehouseState {}
class WarehouseLoading extends WarehouseState {}

/// Trạng thái đã tải dữ liệu thành công.
class WarehouseLoaded extends WarehouseState {
  final List<WarehouseEntity> warehouses;
  final List<WarehouseInventoryEntity> inventory;
  const WarehouseLoaded({required this.warehouses, required this.inventory});
  @override
  List<Object?> get props => [warehouses, inventory];
}

/// Trạng thái lỗi.
class WarehouseError extends WarehouseState {
  final String message;
  const WarehouseError(this.message);
  @override
  List<Object?> get props => [message];
}

/// Trạng thái thông báo hành động (nhập kho) thành công.
class WarehouseActionSuccess extends WarehouseState {
  final String message;
  const WarehouseActionSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

// --- Bloc ---

/// [WarehouseBloc] quản lý logic luồng dữ liệu cho tính năng Kho.
class WarehouseBloc extends Bloc<WarehouseEvent, WarehouseState> {
  final GetWarehousesUseCase getWarehousesUseCase;
  final SearchWarehouseInventoryUseCase searchInventoryUseCase;
  final ImportProductUseCase importProductUseCase;

  WarehouseBloc({
    required this.getWarehousesUseCase,
    required this.searchInventoryUseCase,
    required this.importProductUseCase,
  }) : super(WarehouseInitial()) {
    on<LoadWarehousesEvent>(_onLoadWarehouses);
    on<SearchWarehouseInventoryEvent>(_onSearchInventory);
    on<ImportProductEvent>(_onImportProduct);
  }

  /// Xử lý tải danh sách kho.
  Future<void> _onLoadWarehouses(LoadWarehousesEvent event, Emitter<WarehouseState> emit) async {
    emit(WarehouseLoading());
    final warehousesResult = await getWarehousesUseCase(NoParams());
    
    await warehousesResult.fold(
      (Failure failure) async => emit(WarehouseError(failure.message)),
      (List<WarehouseEntity> warehouses) async {
        if (warehouses.isNotEmpty) {
          // Khi mới vào, hiển thị toàn bộ tồn kho của tất cả các kho
          final inventoryResult = await searchInventoryUseCase(''); 
          inventoryResult.fold(
            (Failure failure) => emit(WarehouseError(failure.message)),
            (List<WarehouseInventoryEntity> inventory) => emit(WarehouseLoaded(warehouses: warehouses, inventory: inventory)),
          );
        } else {
          emit(const WarehouseLoaded(warehouses: [], inventory: []));
        }
      },
    );
  }

  /// Xử lý tìm kiếm trong kho.
  Future<void> _onSearchInventory(SearchWarehouseInventoryEvent event, Emitter<WarehouseState> emit) async {
    final currentState = state;
    if (currentState is WarehouseLoaded) {
      final results = await searchInventoryUseCase(event.query);
      results.fold(
        (Failure failure) => emit(WarehouseError(failure.message)),
        (List<WarehouseInventoryEntity> inventory) => emit(WarehouseLoaded(warehouses: currentState.warehouses, inventory: inventory)),
      );
    }
  }

  /// Xử lý nhập hàng loạt.
  Future<void> _onImportProduct(ImportProductEvent event, Emitter<WarehouseState> emit) async {
    final result = await importProductUseCase(ImportProductParams(
      warehouseId: event.warehouseId,
      items: event.items,
    ));

    result.fold(
      (Failure failure) => emit(WarehouseError(failure.message)),
      (_) {
        emit(const WarehouseActionSuccess('Nhập kho hàng loạt thành công'));
        add(LoadWarehousesEvent()); // Refresh lại dữ liệu sau khi nhập
      },
    );
  }
}
