import 'package:equatable/equatable.dart';

/// [StaffEntity] đại diện cho một nhân viên trong hệ thống.
/// Trường [password] chỉ được dùng khi TẠO MỚI tài khoản (để tạo Firebase Auth).
/// Sau khi tạo xong, password KHÔNG được lưu vào Firestore.
class StaffEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? password; // Chỉ dùng khi tạo mới, không lưu vào DB
  final DateTime? createdAt;

  const StaffEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.password,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, role, createdAt];
}
