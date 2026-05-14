import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/customer_entity.dart';

/// [CustomerModel] kế thừa từ [CustomerEntity] nhưng bổ sung các phương thức
/// để làm việc với Firestore (Data Layer).
class CustomerModel extends CustomerEntity {
  const CustomerModel({
    required super.id,
    required super.name,
    required super.email,
    super.phone,
    super.address,
    super.isLocked,
    super.createdAt,
  });

  /// Chuyển đổi từ dữ liệu Firestore Document sang Model
  factory CustomerModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return CustomerModel(
      id: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'],
      address: data['address'],
      isLocked: data['isLocked'] ?? false,
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as Timestamp).toDate() 
          : null,
    );
  }

  /// Chuyển đổi từ Model sang Map để lưu lên Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'isLocked': isLocked,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : FieldValue.serverTimestamp(),
      'role': 'customer', // Định danh role khách hàng trong collection 'users'
    };
  }

  /// Chuyển Model về Entity (dùng cho Business Logic)
  CustomerEntity toEntity() {
    return CustomerEntity(
      id: id,
      name: name,
      email: email,
      phone: phone,
      address: address,
      isLocked: isLocked,
      createdAt: createdAt,
    );
  }

  /// Tạo Model từ Entity
  factory CustomerModel.fromEntity(CustomerEntity entity) {
    return CustomerModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      address: entity.address,
      isLocked: entity.isLocked,
      createdAt: entity.createdAt,
    );
  }
}
