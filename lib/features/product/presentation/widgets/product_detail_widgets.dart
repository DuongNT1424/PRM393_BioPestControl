import 'package:flutter/material.dart';
import '../../../../shared/theme/app_colors.dart';

/// [ProductDetailHeader] hiển thị hình ảnh sản phẩm trong trang chi tiết.
class ProductDetailHeader extends StatelessWidget {
  final String? imageUrl;

  const ProductDetailHeader({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
      ),
      child: (imageUrl != null && imageUrl!.isNotEmpty)
          ? Image.network(imageUrl!, fit: BoxFit.cover)
          : Center(
              child: Icon(
                Icons.image_not_supported_outlined,
                size: 100,
                color: Colors.grey[400],
              ),
            ),
    );
  }
}

/// [ProductInfoRow] hiển thị một dòng thông tin (icon + label + value).
class ProductInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProductInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey[600], size: 20),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: TextStyle(color: Colors.grey[600], fontSize: 16),
        ),
        const SizedBox(width: 8),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

/// [ProductStatusBadge] hiển thị trạng thái sản phẩm (Đang kinh doanh / Ngừng bán).
class ProductStatusBadge extends StatelessWidget {
  final bool isActive;

  const ProductStatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'Đang kinh doanh' : 'Ngừng kinh doanh',
        style: TextStyle(
          color: isActive ? Colors.green : Colors.red,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
