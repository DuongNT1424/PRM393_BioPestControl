import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

// Import các thành phần của Auth Bloc
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

// Import các widget và màu sắc cho giao diện Authentication
import '../widgets/auth_colors.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/register_header.dart';
import '../widgets/register_side_decoration.dart';
import '../widgets/auth_bento_background.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Bộ điều khiển các trường nhập liệu của form đăng ký
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.surfaceColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        // Lắng nghe trạng thái từ AuthBloc
        listener: (context, state) {
          if (state is Authenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Đăng ký thành công')),
            );
            // Sau khi đăng ký thành công, quay lại trang đăng nhập
            Navigator.pop(context);
          } else if (state is AuthError) {
            // Hiển thị thông báo lỗi từ server/logic
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              // Hình ảnh nền mờ (Bento style)
              const AuthBentoBackground(),
              // Thanh trang trí họa tiết bên trái (chỉ hiện trên màn hình rộng)
              const RegisterSideDecoration(),

              // Vùng nội dung chính của Form
              SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                    child: Container(
                      width: double.infinity,
                      constraints: const BoxConstraints(maxWidth: 480),
                      decoration: BoxDecoration(
                        color: AuthColors.surfaceContainerLowest,
                        border: Border.all(color: const Color(0xFFE8F5E9)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      clipBehavior: Clip.antiAlias, // Cắt các widget con theo bo góc của Container
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Header riêng cho trang đăng ký (Logo BioPest)
                          const RegisterHeader(),

                          // --- Form Đăng ký ---
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Đăng ký tài khoản',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: AuthColors.onSurface,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Nhập thông tin của bạn để bắt đầu',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AuthColors.onSurfaceVariant,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Trường: Họ và tên
                                AuthTextField(
                                  label: 'Họ và tên',
                                  controller: _nameController,
                                  hintText: 'Nguyễn Văn A',
                                  icon: Icons.person_outline,
                                ),
                                const SizedBox(height: 24),

                                // Trường: Email
                                AuthTextField(
                                  label: 'Email',
                                  controller: _emailController,
                                  hintText: 'example@biopest.vn',
                                  icon: Icons.mail_outline,
                                ),
                                const SizedBox(height: 24),

                                // Trường: Số điện thoại
                                AuthTextField(
                                  label: 'Số điện thoại',
                                  controller: _phoneController,
                                  hintText: '0901 234 567',
                                  icon: Icons.call_outlined,
                                ),
                                const SizedBox(height: 24),

                                // Trường: Mật khẩu
                                AuthTextField(
                                  label: 'Mật khẩu',
                                  controller: _passwordController,
                                  hintText: '••••••••',
                                  icon: Icons.lock_outline,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 24),

                                // Trường: Xác nhận mật khẩu
                                AuthTextField(
                                  label: 'Xác nhận mật khẩu',
                                  controller: _confirmPasswordController,
                                  hintText: '••••••••',
                                  icon: Icons.lock_reset_outlined,
                                  obscureText: true,
                                ),
                                const SizedBox(height: 32),

                                // Nút bấm Đăng ký hoặc Loading
                                if (state is AuthLoading)
                                  const Center(child: CircularProgressIndicator())
                                else
                                  ElevatedButton(
                                    onPressed: () {
                                      // Kiểm tra mật khẩu khớp nhau trước khi gửi request
                                      if (_passwordController.text != _confirmPasswordController.text) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Mật khẩu xác nhận không khớp!')),
                                        );
                                        return;
                                      }

                                      // Gửi sự kiện RegisterRequested tới AuthBloc
                                      context.read<AuthBloc>().add(
                                        RegisterRequested(
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                          name: _nameController.text,
                                        ),
                                      );
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AuthColors.primaryContainer,
                                      foregroundColor: Colors.white,
                                      minimumSize: const Size(double.infinity, 56),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      elevation: 0,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Đăng ký',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        const Icon(Icons.arrow_forward, size: 18),
                                      ],
                                    ),
                                  ),

                                const SizedBox(height: 32),

                                // Điều hướng quay lại trang Đăng nhập
                                Center(
                                  child: Wrap(
                                    alignment: WrapAlignment.center,
                                    children: [
                                      Text(
                                        'Bạn đã có tài khoản? ',
                                        style: GoogleFonts.inter(
                                          fontSize: 16,
                                          color: AuthColors.onSurfaceVariant,
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Text(
                                          'Đăng nhập ngay',
                                          style: GoogleFonts.inter(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: AuthColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
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
          );
        },
      ),
    );
  }
}
