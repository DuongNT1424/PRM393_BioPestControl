import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Import các thành phần của Auth Bloc
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

// Import các widget dùng chung và màu sắc
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/shared/widgets/custom_text_field.dart';
import 'package:prm393_biopestcontrol/shared/widgets/custom_button.dart';
import '../widgets/auth_header.dart';
import '../widgets/google_auth_button.dart';
import '../widgets/auth_background_decoration.dart';
import '../widgets/forgot_password_dialog.dart';
import 'register_page.dart';
// Import AuthWrapper không còn cần thiết sau khi chuyển sang popUntil

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Bộ điều khiển cho các trường nhập liệu
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  /// Hàm `build` chịu trách nhiệm vẽ giao diện màn hình Đăng Nhập
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        // `listener` được gọi mỗi khi AuthBloc phát ra một State mới.
        // Dùng để thực hiện các side-effect (hiển thị thông báo, chuyển trang,...) không liên quan đến vẽ UI.
        listener: (context, state) {
          if (state is Authenticated) {
            // Hiển thị thông báo khi đăng nhập thành công
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng nhập thành công')),
            );
            // Pop về route gốc `/` - AuthWrapper ở root sẽ tự động cập nhật giao diện theo AuthBloc
            // KHÔNG dùng pushAndRemoveUntil vì sẽ xóa route gốc gây crash Navigator
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state is AuthError) {
            // Hiển thị lỗi bằng SnackBar nếu quá trình đăng nhập thất bại
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ForgotPasswordSuccess) {
            // Hiển thị thông báo khi gửi email khôi phục thành công
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.green,
              ),
            );
            // Đóng dialog quên mật khẩu nếu đang mở
            Navigator.of(context).pop(); 
          }
        },
        // `builder` được gọi để vẽ lại (rebuild) UI mỗi khi State thay đổi.
        builder: (context, state) {
          return Stack(
            children: [
              // Họa tiết trang trí nền (CustomPainter)
              const AuthBackgroundDecoration(),
              SafeArea(
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      // Đảm bảo chiều cao tối thiểu bằng màn hình
                      minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Header chứa Logo và tiêu đề ứng dụng
                          const AuthHeader(),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                              child: Center(
                                child: Container(
                                  constraints: const BoxConstraints(maxWidth: 440),
                                  padding: const EdgeInsets.all(24),
                                  decoration: BoxDecoration(
                                    color: AppColors.surfaceContainerLowest,
                                    border: Border.all(color: AppColors.outlineVariant),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Đăng nhập',
                                        style: GoogleFonts.inter(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: AppColors.onSurface,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Truy cập vào hệ thống quản lý sinh học của bạn.',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: AppColors.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 32),

                                      // Trường nhập Email
                                      CustomTextField(
                                        label: 'Email của bạn',
                                        controller: _emailController,
                                        hintText: 'ten@biopest.com',
                                        icon: Icons.mail_outline,
                                      ),
                                      const SizedBox(height: 24),

                                      // Trường nhập Mật khẩu
                                      CustomTextField(
                                        label: 'Mật khẩu',
                                        controller: _passwordController,
                                        hintText: '••••••••',
                                        icon: Icons.lock_outline,
                                        obscureText: true,
                                        trailing: GestureDetector(
                                          // Hàm onTap xử lý khi người dùng nhấn "Quên mật khẩu?"
                                          onTap: () {
                                            // Hiển thị hộp thoại nhập email khôi phục
                                            showDialog(
                                              context: context,
                                              builder: (ctx) => ForgotPasswordDialog(
                                                initialEmail: _emailController.text,
                                              ),
                                            );
                                          },
                                          child: Text(
                                            'Quên mật khẩu?',
                                            style: GoogleFonts.inter(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 32),

                                      // Hiển thị vòng xoay nếu đang xử lý, ngược lại hiển thị nút
                                      if (state is AuthLoading)
                                        const Center(child: CircularProgressIndicator())
                                      else
                                        CustomButton(
                                          text: 'Đăng nhập',
                                          icon: Icons.arrow_forward,
                                          // Hàm onPressed xử lý khi nhấn nút Đăng Nhập
                                          onPressed: () {
                                            // Lấy giá trị từ text field và gửi sự kiện LoginRequested tới Bloc
                                            context.read<AuthBloc>().add(
                                              LoginRequested(
                                                email: _emailController.text,
                                                password: _passwordController.text,
                                              ),
                                            );
                                          },
                                        ),

                                      // Phân cách giữa đăng nhập email và google
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 32),
                                        child: Row(
                                          children: [
                                            const Expanded(child: Divider(color: AppColors.outlineVariant)),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 16),
                                              child: Text(
                                                'HOẶC',
                                                style: GoogleFonts.inter(
                                                  fontSize: 12,
                                                  color: AppColors.outlineColor,
                                                ),
                                              ),
                                            ),
                                            const Expanded(child: Divider(color: AppColors.outlineVariant)),
                                          ],
                                        ),
                                      ),

                                      // Nút đăng nhập bằng Google (bên trong xử lý phát sự kiện GoogleLoginRequested)
                                      const GoogleAuthButton(),

                                      const SizedBox(height: 32),

                                      // Chuyển hướng sang trang đăng ký
                                      Center(
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          children: [
                                            Text(
                                              'Chưa có tài khoản? ',
                                              style: GoogleFonts.inter(
                                                fontSize: 16,
                                                color: AppColors.onSurfaceVariant,
                                              ),
                                            ),
                                            GestureDetector(
                                              // Hàm onTap xử lý khi nhấn "Đăng ký ngay"
                                              onTap: () {
                                                // Chuyển hướng (push) sang màn hình Đăng ký
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (_) => const RegisterPage()),
                                                );
                                              },
                                              child: Text(
                                                'Đăng ký ngay',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
