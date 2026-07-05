import 'package:flutter/material.dart';

/// [ManagementStatCard] là Widget hiển thị các chỉ số thống kê trên Dashboard.
/// 
/// Thường dùng trong `GridView`, hiển thị một giá trị số kèm Icon và tiêu đề mô tả.
class ManagementStatCard extends StatelessWidget {
  /// Tiêu đề của chỉ số (vd: "Đơn hàng mới").
  final String title;
  
  /// Giá trị số hiển thị (vd: "12").
  final String value;
  
  /// Biểu tượng minh họa.
  final IconData icon;
  
  /// Màu sắc chủ đạo của Card (dùng để tô màu icon và nền nhạt).
  final Color color;

  const ManagementStatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
