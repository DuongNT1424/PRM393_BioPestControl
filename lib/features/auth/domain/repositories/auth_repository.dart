import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/auth_entity.dart';

/// Lớp Giao diện (Interface) định nghĩa các phương thức xác thực.
/// Repository này nằm ở tầng Domain, nó chỉ mô tả "những gì" hệ thống làm được,
/// còn việc "làm như thế nào" sẽ được triển khai ở tầng Data.
abstract class AuthRepository {
  // Đăng nhập bằng Email và Mật khẩu
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  // Đăng ký tài khoản mới
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String password,
    required String name,
  });

  // Đăng nhập bằng tài khoản Google
  Future<Either<Failure, AuthEntity>> loginWithGoogle();

  // Đăng xuất khỏi hệ thống
  Future<Either<Failure, void>> logout();

  // Kiểm tra trạng thái đăng nhập hiện tại và lấy thông tin người dùng
  Future<Either<Failure, AuthEntity?>> getCurrentUser();
}
