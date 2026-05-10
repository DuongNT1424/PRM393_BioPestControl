import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'auth_colors.dart';

/// Widget nhập liệu tùy chỉnh dành cho Form Authentication.
/// Hỗ trợ Label, HintText, Icon và chế độ ẩn mật khẩu.
class AuthTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final Widget? trailing;

  const AuthTextField({
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
            color: AuthColors.primaryColor,
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
            prefixIcon: Icon(icon, color: AuthColors.outlineColor),
            suffixIcon: trailing,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            // Định nghĩa border khi ở trạng thái bình thường
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: AuthColors.primaryColor.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(4),
            ),
            // Định nghĩa border khi được focus (nhấn vào)
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AuthColors.primaryColor, width: 1.5),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ],
    );
  }
}
