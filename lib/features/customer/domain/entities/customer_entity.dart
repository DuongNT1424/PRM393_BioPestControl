import 'package:equatable/equatable.dart';

/// [CustomerEntity] là thực thể cơ bản của khách hàng trong hệ thống.
/// Đây là tầng lõi (Domain), không phụ thuộc vào database hay framework.
class CustomerEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? address;
  final bool isLocked; // Trạng thái khóa tài khoản
  final DateTime? createdAt;

  const CustomerEntity({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.address,
    this.isLocked = false,
    this.createdAt,
  });

  @override
  List<Object?> get props => [id, name, email, phone, address, isLocked, createdAt];
}
