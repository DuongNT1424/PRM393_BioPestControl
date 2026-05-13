import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

/// Header dành riêng cho khối nội dung chính trong trang Đăng ký.
/// Chứa Logo và slogan, được đặt bên trong container của Form.
class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.headerBackground,
        border: Border(bottom: BorderSide(color: Color(0xFFE8F5E9))),
      ),
      child: Column(
        children: [
          const Icon(Icons.eco, color: AppColors.primaryColor, size: 48),
          const SizedBox(height: 16),
          Text(
            'BioPest Control',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Hệ thống quản lý dịch hại sinh học công nghệ cao',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
