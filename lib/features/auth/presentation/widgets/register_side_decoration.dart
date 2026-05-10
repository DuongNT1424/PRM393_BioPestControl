import 'package:flutter/material.dart';
import 'auth_colors.dart';

/// Thanh trang trí bất đối xứng (Asymmetric Detail) bên trái trang Đăng ký.
/// Chỉ hiển thị khi màn hình đủ rộng (>1024px) để tạo phong cách bento.
class RegisterSideDecoration extends StatelessWidget {
  const RegisterSideDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    // Ẩn nếu màn hình hẹp (Mobile)
    if (MediaQuery.of(context).size.width <= 1024) {
      return const SizedBox.shrink();
    }
    
    return Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: 64,
      child: Container(
        color: AuthColors.headerBackground,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            Icon(Icons.eco, color: AuthColors.primaryColor.withOpacity(0.3)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: 1,
                  color: AuthColors.primaryColor.withOpacity(0.1),
                ),
              ),
            ),
            Icon(Icons.verified, color: AuthColors.primaryColor.withOpacity(0.3)),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
