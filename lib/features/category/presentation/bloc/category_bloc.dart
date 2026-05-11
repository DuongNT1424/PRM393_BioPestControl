import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_categories_usecase.dart';
import '../../domain/usecases/add_category_usecase.dart';
import '../../domain/usecases/update_category_usecase.dart';
import '../../domain/usecases/delete_category_usecase.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GetCategoriesUseCase getCategoriesUseCase;
  final AddCategoryUseCase addCategoryUseCase;
  final UpdateCategoryUseCase updateCategoryUseCase;
  final DeleteCategoryUseCase deleteCategoryUseCase;

  // Sử dụng positional parameters để tránh lỗi No constructor 'CategoryBloc.'
  CategoryBloc(
    this.getCategoriesUseCase,
    this.addCategoryUseCase,
    this.updateCategoryUseCase,
    this.deleteCategoryUseCase,
  ) : super(CategoryInitial()) {
    on<LoadCategoriesEvent>(_onLoadCategories);
    on<AddCategoryEvent>(_onAddCategory);
    on<UpdateCategoryEvent>(_onUpdateCategory);
    on<DeleteCategoryEvent>(_onDeleteCategory);
  }

  Future<void> _onLoadCategories(LoadCategoriesEvent event, Emitter<CategoryState> emit) async {
    emit(CategoryLoading());
    final result = await getCategoriesUseCase();
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (categories) => emit(CategoryLoaded(categories)),
    );
  }

  Future<void> _onAddCategory(AddCategoryEvent event, Emitter<CategoryState> emit) async {
    final result = await addCategoryUseCase(event.category);
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (_) => add(LoadCategoriesEvent()),
    );
  }

  Future<void> _onUpdateCategory(UpdateCategoryEvent event, Emitter<CategoryState> emit) async {
    final result = await updateCategoryUseCase(event.category);
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (_) => add(LoadCategoriesEvent()),
    );
  }

  Future<void> _onDeleteCategory(DeleteCategoryEvent event, Emitter<CategoryState> emit) async {
    final result = await deleteCategoryUseCase(event.id);
    result.fold(
      (failure) => emit(CategoryError(failure.message)),
      (_) => add(LoadCategoriesEvent()),
    );
  }
}
