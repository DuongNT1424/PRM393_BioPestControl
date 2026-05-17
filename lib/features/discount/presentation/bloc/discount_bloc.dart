import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_discounts_usecase.dart';
import '../../domain/usecases/add_discount_usecase.dart';
import '../../domain/usecases/update_discount_usecase.dart';
import '../../domain/usecases/delete_discount_usecase.dart';
import '../../domain/usecases/search_discounts_usecase.dart';
import '../../domain/usecases/filter_discounts_usecase.dart';
import 'discount_event.dart';
import 'discount_state.dart';

/// [DiscountBloc] quản lý luồng sự kiện và trạng thái cho tính năng Giảm giá.
/// Tuân thủ nguyên tắc: UI gửi Event -> Bloc xử lý logic thông qua UseCases -> Phát ra State mới.
class DiscountBloc extends Bloc<DiscountEvent, DiscountState> {
  final GetDiscountsUseCase getDiscountsUseCase;
  final AddDiscountUseCase addDiscountUseCase;
  final UpdateDiscountUseCase updateDiscountUseCase;
  final DeleteDiscountUseCase deleteDiscountUseCase;
  final SearchDiscountsUseCase searchDiscountsUseCase;
  final FilterDiscountsUseCase filterDiscountsUseCase;

  DiscountBloc({
    required this.getDiscountsUseCase,
    required this.addDiscountUseCase,
    required this.updateDiscountUseCase,
    required this.deleteDiscountUseCase,
    required this.searchDiscountsUseCase,
    required this.filterDiscountsUseCase,
  }) : super(DiscountInitial()) {
    // Đăng ký các trình xử lý sự kiện
    on<LoadDiscounts>(_onLoadDiscounts);
    on<SearchDiscounts>(_onSearchDiscounts);
    on<FilterDiscounts>(_onFilterDiscounts);
    on<AddDiscount>(_onAddDiscount);
    on<UpdateDiscount>(_onUpdateDiscount);
    on<DeleteDiscount>(_onDeleteDiscount);
  }

  /// Xử lý tải danh sách giảm giá
  Future<void> _onLoadDiscounts(LoadDiscounts event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      final discounts = await getDiscountsUseCase();
      emit(DiscountsLoaded(discounts));
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _onSearchDiscounts(SearchDiscounts event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      final discounts = await searchDiscountsUseCase(event.query);
      emit(DiscountsLoaded(discounts));
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _onFilterDiscounts(FilterDiscounts event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      final discounts = await filterDiscountsUseCase(isActive: event.isActive);
      emit(DiscountsLoaded(discounts));
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _onAddDiscount(AddDiscount event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      await addDiscountUseCase(event.discount);
      emit(const DiscountOperationSuccess('Discount created successfully'));
      add(LoadDiscounts());
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _onUpdateDiscount(UpdateDiscount event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      await updateDiscountUseCase(event.discount);
      emit(const DiscountOperationSuccess('Discount updated successfully'));
      add(LoadDiscounts());
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }

  Future<void> _onDeleteDiscount(DeleteDiscount event, Emitter<DiscountState> emit) async {
    emit(DiscountLoading());
    try {
      await deleteDiscountUseCase(event.id);
      emit(const DiscountOperationSuccess('Discount deleted successfully'));
      add(LoadDiscounts());
    } catch (e) {
      emit(DiscountError(e.toString()));
    }
  }
}
