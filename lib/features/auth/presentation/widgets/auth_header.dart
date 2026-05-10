import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_colors.dart';

/// Header thương hiệu cho trang Đăng nhập.
/// Chứa Logo và tên ứng dụng kèm câu slogan giới thiệu.
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AuthColors.headerBackground,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.eco, color: AuthColors.primaryColor, size: 48),
              const SizedBox(width: 8),
              Text(
                'BioPest Control',
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AuthColors.primaryColor,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Giải pháp kiểm soát côn trùng sinh học chính xác và bền vững cho nông nghiệp công nghệ cao.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AuthColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
