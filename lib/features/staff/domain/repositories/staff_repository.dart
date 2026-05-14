import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/staff_entity.dart';

/// [StaffRepository] định nghĩa các hành động quản lý nhân viên.
abstract class StaffRepository {
  /// Lấy danh sách tất cả nhân viên (role là 'staff').
  Future<Either<Failure, List<StaffEntity>>> getStaffs();
  
  /// Thêm nhân viên mới vào Firestore.
  Future<Either<Failure, void>> addStaff(StaffEntity staff);
  
  /// Cập nhật thông tin nhân viên.
  Future<Either<Failure, void>> updateStaff(StaffEntity staff);
  
  /// Xóa nhân viên khỏi hệ thống.
  Future<Either<Failure, void>> deleteStaff(String id);
  
  /// Tìm kiếm nhân viên theo tên hoặc email.
  Future<Either<Failure, List<StaffEntity>>> searchStaffs(String query);

  /// Gửi email đặt lại mật khẩu cho nhân viên.
  Future<Either<Failure, void>> sendPasswordReset(String email);
}
