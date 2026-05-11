import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/add_product_usecase.dart';
import '../../domain/usecases/delete_product_usecase.dart';
import '../../domain/usecases/filter_products_usecase.dart';
import '../../domain/usecases/get_product_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';
import '../../domain/usecases/search_products_usecase.dart';
import '../../domain/usecases/update_product_usecase.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProductsUseCase getProductsUseCase;
  final GetProductUseCase getProductUseCase;
  final SearchProductsUseCase searchProductsUseCase;
  final FilterProductsUseCase filterProductsUseCase;
  final AddProductUseCase addProductUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;

  ProductBloc({
    required this.getProductsUseCase,
    required this.getProductUseCase,
    required this.searchProductsUseCase,
    required this.filterProductsUseCase,
    required this.addProductUseCase,
    required this.updateProductUseCase,
    required this.deleteProductUseCase,
  }) : super(ProductInitial()) {
    on<LoadProductsEvent>(_onLoadProducts);
    on<SearchProductEvent>(_onSearchProducts);
    on<FilterProductEvent>(_onFilterProducts);
    on<AddProductEvent>(_onAddProduct);
    on<UpdateProductEvent>(_onUpdateProduct);
    on<DeleteProductEvent>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(LoadProductsEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await getProductsUseCase();
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onSearchProducts(SearchProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await searchProductsUseCase(event.query);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onFilterProducts(FilterProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await filterProductsUseCase(FilterProductParams(
      categoryId: event.categoryId,
      isActive: event.isActive,
    ));
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (products) => emit(ProductLoaded(products)),
    );
  }

  Future<void> _onAddProduct(AddProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await addProductUseCase(event.product);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) {
        emit(const ProductActionSuccess('Thêm sản phẩm thành công'));
        add(LoadProductsEvent());
      },
    );
  }

  Future<void> _onUpdateProduct(UpdateProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await updateProductUseCase(event.product);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) {
        emit(const ProductActionSuccess('Cập nhật sản phẩm thành công'));
        add(LoadProductsEvent());
      },
    );
  }

  Future<void> _onDeleteProduct(DeleteProductEvent event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    final result = await deleteProductUseCase(event.id);
    result.fold(
      (failure) => emit(ProductError(failure.message)),
      (_) {
        emit(const ProductActionSuccess('Xóa sản phẩm thành công'));
        add(LoadProductsEvent());
      },
    );
  }
}
