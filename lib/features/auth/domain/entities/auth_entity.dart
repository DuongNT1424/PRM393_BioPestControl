import 'package:equatable/equatable.dart';

/// Lớp Entity đại diện cho người dùng sau khi xác thực thành công.
/// Đây là lớp thuộc tầng Domain, chứa dữ liệu cốt lõi và không phụ thuộc vào bất kỳ framework nào.
class AuthEntity extends Equatable {
  // Mã định danh duy nhất của người dùng (thường từ Firebase UID)
  final String? id;
  // Địa chỉ email của người dùng
  final String? email;
  // Tên hiển thị của người dùng
  final String? name;
  // Đường dẫn ảnh đại diện (nếu có)
  final String? photoUrl;

  final String? role;

  const AuthEntity({
    this.id,
    this.email,
    this.name,
    this.photoUrl,
    this.role,
  });

  @override
  // Props giúp Equatable so sánh các đối tượng dựa trên giá trị thuộc tính
  List<Object?> get props => [id, email, name, photoUrl, role];
}
