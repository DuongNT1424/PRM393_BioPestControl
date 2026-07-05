import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

/// Nút đăng nhập nhanh bằng tài khoản Google.
/// Thiết kế tuân thủ hướng dẫn nhận diện của Google.
class GoogleAuthButton extends StatelessWidget {
  const GoogleAuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        // Xử lý sự kiện đăng nhập Google
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        side: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.1)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        backgroundColor: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo Google (Giả lập bằng icon search hoặc có thể thay bằng asset ảnh)
          const Icon(Icons.search, color: Colors.blue), 
          const SizedBox(width: 12),
          Text(
            'Tiếp tục với Google',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
