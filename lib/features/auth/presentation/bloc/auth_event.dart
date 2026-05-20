import 'package:equatable/equatable.dart';

/// Lớp trừu tượng đại diện cho các sự kiện (Events) của AuthBloc.
/// Mỗi khi người dùng tương tác với giao diện, một Event sẽ được gửi đi.
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

/// Sự kiện yêu cầu Đăng nhập bằng Email và Password
class LoginRequested extends AuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Sự kiện yêu cầu Đăng ký tài khoản mới
class RegisterRequested extends AuthEvent {
  final String email;
  final String password;
  final String name;
  final String phone;

  const RegisterRequested({
    required this.email,
    required this.password,
    required this.name,
    this.phone = '',
  });

  @override
  List<Object?> get props => [email, password, name, phone];
}

/// Sự kiện yêu cầu đăng nhập bằng tài khoản Google
class GoogleLoginRequested extends AuthEvent {}

/// Sự kiện yêu cầu đăng xuất
class LogoutRequested extends AuthEvent {}

class ForgotPasswordRequested extends AuthEvent {
  final String email;

  const ForgotPasswordRequested(this.email);

  @override
  List<Object> get props => [email];
}

/// Sự kiện kiểm tra trạng thái đăng nhập hiện tại khi khởi động app
class AuthCheckRequested extends AuthEvent {}
