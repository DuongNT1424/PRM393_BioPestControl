import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_customers_usecase.dart';
import '../../domain/usecases/get_customer_detail_usecase.dart';
import '../../domain/usecases/update_customer_usecase.dart';
import '../../domain/usecases/lock_customer_usecase.dart';
import '../../domain/usecases/unlock_customer_usecase.dart';
import '../../domain/usecases/search_customers_usecase.dart';
import '../../domain/usecases/filter_customers_usecase.dart';
import 'customer_event.dart';
import 'customer_state.dart';

/// [CustomerBloc] quản lý logic nghiệp vụ cho giao diện quản lý khách hàng.
/// Nó nhận các sự kiện (Event) và phát ra các trạng thái (State) tương ứng.
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final GetCustomersUseCase getCustomersUseCase;
  final GetCustomerDetailUseCase getCustomerDetailUseCase;
  final UpdateCustomerUseCase updateCustomerUseCase;
  final LockCustomerUseCase lockCustomerUseCase;
  final UnlockCustomerUseCase unlockCustomerUseCase;
  final SearchCustomersUseCase searchCustomersUseCase;
  final FilterCustomersUseCase filterCustomersUseCase;

  CustomerBloc({
    required this.getCustomersUseCase,
    required this.getCustomerDetailUseCase,
    required this.updateCustomerUseCase,
    required this.lockCustomerUseCase,
    required this.unlockCustomerUseCase,
    required this.searchCustomersUseCase,
    required this.filterCustomersUseCase,
  }) : super(CustomerInitial()) {
    // Đăng ký các trình xử lý sự kiện
    on<LoadCustomers>(_onLoadCustomers);
    on<SearchCustomers>(_onSearchCustomers);
    on<FilterCustomers>(_onFilterCustomers);
    on<UpdateCustomer>(_onUpdateCustomer);
    on<ToggleCustomerLock>(_onToggleCustomerLock);
    on<GetCustomerDetail>(_onGetCustomerDetail);
  }

  /// Xử lý sự kiện tải danh sách khách hàng
  Future<void> _onLoadCustomers(LoadCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await getCustomersUseCase(NoParams());
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomersLoaded(customers)),
    );
  }

  /// Xử lý sự kiện tìm kiếm khách hàng theo tên/email/phone
  Future<void> _onSearchCustomers(SearchCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await searchCustomersUseCase(event.query);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomersLoaded(customers)),
    );
  }

  /// Xử lý sự kiện lọc khách hàng theo trạng thái khóa/mở
  Future<void> _onFilterCustomers(FilterCustomers event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await filterCustomersUseCase(event.isLocked);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customers) => emit(CustomersLoaded(customers)),
    );
  }

  /// Xử lý sự kiện cập nhật thông tin khách hàng
  Future<void> _onUpdateCustomer(UpdateCustomer event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await updateCustomerUseCase(event.customer);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(const CustomerOperationSuccess('Customer updated successfully'));
        add(LoadCustomers());
      },
    );
  }

  /// Xử lý sự kiện khóa/mở khóa khách hàng
  Future<void> _onToggleCustomerLock(ToggleCustomerLock event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final actionResult = event.isLocked 
        ? await lockCustomerUseCase(event.id)
        : await unlockCustomerUseCase(event.id);

    actionResult.fold(
      (failure) => emit(CustomerError(failure.message)),
      (_) {
        emit(CustomerOperationSuccess(event.isLocked ? 'Customer locked' : 'Customer unlocked'));
        add(LoadCustomers());
      },
    );
  }

  /// Xử lý sự kiện lấy chi tiết một khách hàng
  Future<void> _onGetCustomerDetail(GetCustomerDetail event, Emitter<CustomerState> emit) async {
    emit(CustomerLoading());
    final result = await getCustomerDetailUseCase(event.id);
    result.fold(
      (failure) => emit(CustomerError(failure.message)),
      (customer) => emit(CustomerDetailLoaded(customer)),
    );
  }
}
