import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';

/// Lớp trừu tượng đại diện cho các trạng thái (States) của Authentication.
/// Giao diện sẽ lắng nghe và thay đổi dựa trên các trạng thái này.
abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object?> get props => [];
}

/// Trạng thái ban đầu (Chưa làm gì)
class AuthInitial extends AuthState {}

/// Trạng thái đang xử lý (Đang đăng nhập, đang đăng ký...) - Hiển thị Loading
class AuthLoading extends AuthState {}

/// Trạng thái đã xác thực thành công - Chứa thông tin người dùng
class Authenticated extends AuthState {
  final AuthEntity user;

  const Authenticated(this.user);

  @override
  List<Object?> get props => [user];
}

/// Trạng thái chưa xác thực (Người dùng chưa đăng nhập)
class Unauthenticated extends AuthState {}

/// Trạng thái gặp lỗi trong quá trình xử lý
class AuthError extends AuthState {
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];
}
