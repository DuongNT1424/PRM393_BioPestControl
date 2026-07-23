import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_with_google_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/forgot_password_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

/// [AuthBloc] Quản lý trạng thái Xác thực (Authentication) cho toàn bộ ứng dụng.
/// Đóng vai trò bộ não điều phối dữ liệu giữa tầng Domain và Giao diện (Presentation).
///
/// Luồng hoạt động cơ bản (Auth Flow):
/// 1. Giao diện (ví dụ: LoginPage, RegisterPage) thu thập thông tin người dùng và phát sự kiện (ví dụ: LoginRequested).
/// 2. [AuthBloc] nhận sự kiện, chuyển trạng thái sang [AuthLoading] để giao diện hiện vòng xoay tải.
/// 3. Bloc gọi các UseCase tương ứng ở tầng Domain (ví dụ: LoginUseCase, RegisterUseCase).
/// 4. Các UseCase này sẽ gọi [AuthRepository], và Repository gọi [AuthRemoteDataSource] tương tác với Firebase.
/// 5. Sau khi nhận kết quả (Right/Thành công hoặc Left/Thất bại), Bloc phát ra trạng thái mới 
///    (như [Authenticated] hoặc [AuthError]) để giao diện tự động điều hướng hoặc báo lỗi.
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // Các UseCases được tiêm (inject) vào Bloc từ Dependency Injection

  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LoginWithGoogleUseCase loginWithGoogleUseCase;
  final LogoutUseCase logoutUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.loginWithGoogleUseCase,
    required this.logoutUseCase,
    required this.getCurrentUserUseCase,
    required this.forgotPasswordUseCase,
  }) : super(AuthInitial()) {
    // Đăng ký các trình xử lý sự kiện (Event Handlers)
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<GoogleLoginRequested>(_onGoogleLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<ForgotPasswordRequested>(_onForgotPasswordRequested);
  }

// Xử lý sự kiện đăng nhập
Future<void> _onLoginRequested(
  LoginRequested event,
  Emitter<AuthState> emit,
) async {

  // Phát ra trạng thái loading để hiển thị vòng quay chờ trên UI
  emit(AuthLoading());

  // Gọi LoginUseCase để thực hiện nghiệp vụ đăng nhập
  // Truyền email và password từ event vào LoginParams
  final result = await loginUseCase(
    LoginParams(
      email: event.email,
      password: event.password,
    ),
  );

  // result có kiểu Either<Failure, User>
  // fold dùng để xử lý cả 2 trường hợp:
  result.fold(

    // Nếu đăng nhập thất bại -> phát ra trạng thái lỗi
    (failure) => emit(AuthError(failure.message)),

    // Nếu đăng nhập thành công -> phát ra trạng thái đã xác thực
    (user) => emit(Authenticated(user)),
  );
}

  // Hàm xử lý khi người dùng nhấn nút đăng ký
Future<void> _onRegisterRequested(
  RegisterRequested event,
  Emitter<AuthState> emit,
) async {

  // Chuyển state sang loading để UI hiển thị vòng quay chờ
  emit(AuthLoading());

  // Gọi RegisterUseCase để thực hiện nghiệp vụ đăng ký tài khoản
  // Truyền các thông tin người dùng từ event vào RegisterParams
  final result = await registerUseCase(
    RegisterParams(
      email: event.email,
      password: event.password,
      name: event.name,
      phone: event.phone,
    ),
  );

  // result có kiểu Either<Failure, User>
  // fold dùng để xử lý 2 trường hợp: thất bại hoặc thành công
  result.fold(

    // Nếu đăng ký thất bại -> phát ra state lỗi
    (failure) => emit(AuthError(failure.message)),

    // Nếu đăng ký thành công -> phát ra state đã xác thực
    // và lưu thông tin người dùng
    (user) => emit(Authenticated(user)),
  );
}

  // Hàm xử lý khi người dùng chọn đăng nhập bằng Google
Future<void> _onGoogleLoginRequested(
  GoogleLoginRequested event,
  Emitter<AuthState> emit,
) async {

  // Chuyển state sang loading để UI hiển thị trạng thái đang xử lý
  emit(AuthLoading());

  // Gọi UseCase đăng nhập bằng Google
  // Tham số null vì use case này không cần dữ liệu đầu vào
  final result = await loginWithGoogleUseCase(null);

  // Kết quả trả về có kiểu Either<Failure, User>
  // Dùng fold để xử lý cả 2 trường hợp
  result.fold(

    // Nếu đăng nhập thất bại -> phát ra state lỗi
    (failure) => emit(AuthError(failure.message)),

    // Nếu đăng nhập thành công -> phát ra state đã xác thực
    (user) => emit(Authenticated(user)),
  );
}

// Hàm xử lý khi người dùng yêu cầu đăng xuất
Future<void> _onLogoutRequested(
  LogoutRequested event,
  Emitter<AuthState> emit,
) async {

  // Gọi LogoutUseCase để xóa phiên đăng nhập hiện tại
  // (token, session hoặc thông tin đăng nhập được lưu)
  await logoutUseCase(null);

  // Sau khi đăng xuất thành công,
  // chuyển state về chưa xác thực
  emit(Unauthenticated());
}

// Hàm kiểm tra trạng thái đăng nhập khi ứng dụng khởi động
Future<void> _onAuthCheckRequested(
  AuthCheckRequested event,
  Emitter<AuthState> emit,
) async {

  // Gọi UseCase để lấy thông tin người dùng hiện tại
  // (từ Firebase, token hoặc local storage)
  final result = await getCurrentUserUseCase(null);

  // Kết quả trả về có kiểu Either<Failure, User?>
  result.fold(

    // Nếu có lỗi khi lấy thông tin người dùng
    (_) => emit(Unauthenticated()),

    // Nếu gọi thành công
    (user) {

      // Có thông tin user -> người dùng đã đăng nhập
      if (user != null) {
        emit(Authenticated(user));
      }

      // Không có user -> người dùng chưa đăng nhập
      else {
        emit(Unauthenticated());
      }
    },
  );
}

// Hàm xử lý khi người dùng yêu cầu đặt lại mật khẩu
Future<void> _onForgotPasswordRequested(
  ForgotPasswordRequested event,
  Emitter<AuthState> emit,
) async {

  // Chuyển state sang loading để UI hiển thị trạng thái đang xử lý
  emit(AuthLoading());

  // Gọi ForgotPasswordUseCase và truyền email người dùng nhập
  // Hệ thống sẽ gửi email chứa liên kết đặt lại mật khẩu
  final result = await forgotPasswordUseCase(event.email);

  // Kết quả trả về có kiểu Either<Failure, void>
  result.fold(

    // Nếu gửi email thất bại -> phát ra state lỗi
    (failure) => emit(AuthError(failure.message)),

    // Nếu gửi email thành công -> phát ra state thành công
    (_) => emit(
      const ForgotPasswordSuccess(
        'Password reset email sent',
      ),
    ),
  );
}
}
