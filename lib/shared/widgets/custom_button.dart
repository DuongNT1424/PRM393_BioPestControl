import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';

/// [CustomButton] là Widget nút bấm chuẩn hóa cho toàn bộ dự án.
/// 
/// Widget này giúp duy trì kiểu dáng đồng nhất (Brand Identity) cho các hành động
/// chính như Đăng nhập, Đăng ký, Lưu dữ liệu... 
/// Hỗ trợ hiển thị Icon đi kèm và có thể tùy chỉnh màu sắc linh hoạt.
class CustomButton extends StatelessWidget {
  /// Văn bản hiển thị trên nút.
  final String text;
  
  /// Biểu tượng đi kèm văn bản.
  final IconData icon;
  
  /// Hàm thực thi khi người dùng nhấn nút.
  final VoidCallback onPressed;
  
  /// Màu nền tùy chỉnh (Nếu null sẽ dùng màu Primary mặc định).
  final Color? backgroundColor;
  
  /// Màu chữ/icon tùy chỉnh.
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryContainer,
        foregroundColor: foregroundColor ?? AppColors.onPrimaryContainer,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
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
