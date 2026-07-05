import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

/// [CustomTextField] là Widget nhập liệu tùy chỉnh dùng chung cho toàn bộ ứng dụng.
/// 
/// Widget này cung cấp giao diện chuẩn bao gồm Label phía trên, ô nhập liệu có Border
/// bo tròn nhẹ, hỗ trợ Prefix Icon và Trailing Widget (như nút hiện/ẩn mật khẩu).
class CustomTextField extends StatelessWidget {
  /// Tiêu đề hiển thị ngay phía trên ô nhập liệu.
  final String label;
  
  /// Bộ điều khiển dữ liệu nhập vào.
  final TextEditingController controller;
  
  /// Văn bản gợi ý hiển thị mờ bên trong ô nhập.
  final String hintText;
  
  /// Biểu tượng ở đầu ô nhập liệu.
  final IconData icon;
  
  /// Chế độ ẩn văn bản (dùng cho Mật khẩu).
  final bool obscureText;
  
  /// Widget hiển thị ở cuối ô nhập liệu.
  final Widget? trailing;

  const CustomTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label phía trên input
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 8),
        // Ô nhập liệu
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: GoogleFonts.inter(fontSize: 16),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: AppColors.outlineColor),
            suffixIcon: trailing,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.2)),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
