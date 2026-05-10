import 'package:flutter/material.dart';

/// Hiệu ứng nền "Bento style" với một bức ảnh mờ ở góc phải.
/// Tạo cảm giác chuyên nghiệp và công nghệ cao cho các trang Auth.
class AuthBentoBackground extends StatelessWidget {
  const AuthBentoBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 0,
      top: 0,
      bottom: 0,
      width: MediaQuery.of(context).size.width / 3,
      child: Opacity(
        opacity: 0.05, // Độ mờ rất thấp để không làm rối mắt
        child: Image.network(
          'https://lh3.googleusercontent.com/aida-public/AB6AXuB34LvuQZ9_lScFh52TORykfvLBEULjmf9hRnh9q0vHOU4_6_nqSWf5qe2cj0RV7zdaQeU-HeBkCshwXrJeyQpllZObM91FboerIaieB-oXoBT1auCjYTYCDl0MaN2XGCt_vKJrza-9EHgZc4IlKEbR4fat5yQP-vJgJZD7VmGrNBquGc0XY3JoNu7YVx5iXovcxf2OHGKc8xIOsFMi_DPtWkllAkxhaZUHEkRCUVaN6TRn4_qzoiLobO_yJ5W4KFHirAx0uR5SUSL_',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
