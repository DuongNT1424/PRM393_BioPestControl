import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_colors.dart';

/// Nút bấm chính (Primary Button) cho các hành động quan trọng (Đăng nhập, Đăng ký).
/// Có hiệu ứng hover và kiểu dáng đồng nhất với thiết kế.
class AuthButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  const AuthButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AuthColors.primaryContainer,
        foregroundColor: AuthColors.onPrimaryContainer,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24), // Bo tròn lớn theo kiểu hiện đại
        ),
        elevation: 0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(width: 8),
          Icon(icon, size: 20),
        ],
      ),
    );
  }
}
