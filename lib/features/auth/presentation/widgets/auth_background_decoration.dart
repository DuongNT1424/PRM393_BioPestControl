import 'package:flutter/material.dart';

/// Lớp nền trang trí sử dụng CustomPainter để vẽ các họa tiết hình học mờ.
/// Giúp giao diện trông hiện đại và có chiều sâu hơn mà không cần dùng ảnh SVG.
class AuthBackgroundDecoration extends StatelessWidget {
  const AuthBackgroundDecoration({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: -100,
      child: Opacity(
        opacity: 0.05,
        child: SizedBox(
          width: 400,
          height: 800,
          child: CustomPaint(
            painter: _BackgroundDecorationPainter(),
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF0D631B)
      ..style = PaintingStyle.fill;

    // Vẽ một hình tròn lớn mờ ở góc
    canvas.drawCircle(Offset(size.width, 0), 200, paint);
    
    // Vẽ một hình đa giác cách điệu
    final path = Path()
      ..moveTo(size.width * 0.5, 0)
      ..lineTo(size.width, size.height * 0.2)
      ..lineTo(size.width * 0.8, size.height * 0.5)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
