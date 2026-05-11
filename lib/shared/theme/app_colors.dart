import 'package:flutter/material.dart';

/// [AppColors] là lớp trung tâm quản lý hệ thống màu sắc của ứng dụng.
/// 
/// Theo yêu cầu của USER: Chỉ sử dụng màu TRẮNG và màu XANH (0xFF0D631B).
class AppColors {
  // --- Màu chính (Brand Colors) ---
  
  /// Màu xanh lá cây đậm đặc trưng của thương hiệu BioPest.
  static const Color primaryColor = Color(0xFF0D631B);
  
  /// Màu xanh dùng cho các Container hoặc Button (Sử dụng đồng nhất màu Primary).
  static const Color primaryContainer = Color(0xFF0D631B);
  
  /// Màu chữ trên nền xanh (Dùng màu trắng).
  static const Color onPrimaryContainer = Color(0xFFFFFFFF);
  
  // --- Màu nền và bề mặt (Surface & Background) ---
  
  /// Màu nền chủ đạo (Trắng).
  static const Color backgroundColor = Color(0xFFFFFFFF);
  
  /// Màu bề mặt (Trắng).
  static const Color surfaceColor = Color(0xFFFFFFFF);
  
  /// Màu trắng tuyệt đối.
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  
  /// Màu nền cho Header (Trắng).
  static const Color headerBackground = Color(0xFFFFFFFF);
  
  // --- Màu bổ trợ và kiểu chữ ---
  
  /// Màu chữ chính (Màu Đen).
  static const Color onSurface = Color(0xFF000000);
  
  /// Màu chữ phụ (Màu Đen).
  static const Color onSurfaceVariant = Color(0xFF000000);
  
  /// Màu đường viền (Dùng xanh).
  static const Color outlineColor = Color(0xFF0D631B);
  
  /// Màu đường viền nhạt (Dùng xanh với độ mờ).
  static const Color outlineVariant = Color(0xFF0D631B);
}
