import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_staff_usecase.dart';
import '../../domain/usecases/delete_staff_usecase.dart';
import '../../domain/usecases/get_staffs_usecase.dart';
import '../../domain/usecases/search_staffs_usecase.dart';
import '../../domain/usecases/update_staff_usecase.dart';
import '../../domain/usecases/send_password_reset_usecase.dart';
import 'staff_event.dart';
import 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {
  final GetStaffsUseCase getStaffsUseCase;
  final AddStaffUseCase addStaffUseCase;
  final UpdateStaffUseCase updateStaffUseCase;
  final DeleteStaffUseCase deleteStaffUseCase;
  final SearchStaffsUseCase searchStaffsUseCase;
  final SendPasswordResetUseCase sendPasswordResetUseCase;

  StaffBloc({
    required this.getStaffsUseCase,
    required this.addStaffUseCase,
    required this.updateStaffUseCase,
    required this.deleteStaffUseCase,
    required this.searchStaffsUseCase,
    required this.sendPasswordResetUseCase,
  }) : super(StaffInitial()) {
    on<LoadStaffsEvent>(_onLoadStaffs);
    on<AddStaffEvent>(_onAddStaff);
    on<UpdateStaffEvent>(_onUpdateStaff);
    on<DeleteStaffEvent>(_onDeleteStaff);
    on<SearchStaffsEvent>(_onSearchStaffs);
    on<SendPasswordResetEvent>(_onSendPasswordReset);
  }

  Future<void> _onLoadStaffs(LoadStaffsEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await getStaffsUseCase(NoParams());
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (staffs) => emit(StaffLoaded(staffs)),
    );
  }

  Future<void> _onAddStaff(AddStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await addStaffUseCase(event.staff);
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (_) {
        emit(const StaffActionSuccess('Thêm nhân viên thành công'));
        add(LoadStaffsEvent());
      },
    );
  }

  Future<void> _onUpdateStaff(UpdateStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await updateStaffUseCase(event.staff);
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (_) {
        emit(const StaffActionSuccess('Cập nhật nhân viên thành công'));
        add(LoadStaffsEvent());
      },
    );
  }

  Future<void> _onDeleteStaff(DeleteStaffEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await deleteStaffUseCase(event.id);
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (_) {
        emit(const StaffActionSuccess('Xóa nhân viên thành công'));
        add(LoadStaffsEvent());
      },
    );
  }

  Future<void> _onSearchStaffs(SearchStaffsEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await searchStaffsUseCase(event.query);
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (staffs) => emit(StaffLoaded(staffs)),
    );
  }

  Future<void> _onSendPasswordReset(SendPasswordResetEvent event, Emitter<StaffState> emit) async {
    emit(StaffLoading());
    final result = await sendPasswordResetUseCase(event.email);
    result.fold(
      (failure) => emit(StaffError(failure.message)),
      (_) {
        emit(const StaffActionSuccess('✅ Đã gửi email reset mật khẩu. Hãy kiểm tra cả hộp thư Spam.'));
        // Không cần tải lại danh sách
      },
    );
  }
}
