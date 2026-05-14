import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';

/// Widget nhãn (Label) dùng chung cho các trường nhập liệu.
class StaffFieldLabel extends StatelessWidget {
  final String label;
  const StaffFieldLabel(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }
}

/// Widget cho các trường nhập liệu text trong Staff Form.
class StaffInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final String? Function(String?)? validator;
  final bool readOnly;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;

  const StaffInputField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.validator,
    this.readOnly = false,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        prefixIcon: Icon(icon, color: AppColors.primaryColor),
        suffixIcon: suffixIcon,
        fillColor: readOnly ? Colors.grey[100] : null,
        filled: readOnly,
      ),
      validator: validator,
    );
  }
}

/// Phần hiển thị thông tin hỗ trợ đổi mật khẩu (Chỉ dùng khi Edit).
class StaffResetPasswordSection extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onReset;

  const StaffResetPasswordSection({
    super.key,
    required this.isLoading,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber[200]!),
          ),
          child: const Row(
            children: [
              Icon(Icons.info_outline, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Email không thể thay đổi. Để đổi mật khẩu, dùng nút bên dưới.',
                  style: TextStyle(fontSize: 12, color: Colors.brown),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: OutlinedButton.icon(
            onPressed: isLoading ? null : onReset,
            icon: isLoading
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.lock_reset, color: AppColors.primaryColor),
            label: Text(isLoading ? 'Đang gửi...' : 'Gửi email đặt lại mật khẩu'),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }
}
