import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/notification.dart';

/// [NotificationModel] thừa kế từ [NotificationEntity] phục vụ cho việc biểu diễn dữ liệu ở tầng Data.
/// Cung cấp các phương thức chuyển đổi dữ liệu qua lại với Cloud Firestore (serialization & deserialization).
class NotificationModel extends NotificationEntity {
  const NotificationModel({
    required super.id,
    required super.title,
    required super.body,
    required super.type,
    required super.userId,
    required super.isRead,
    required super.createdAt,
  });

  /// Chuyển đổi từ tài liệu (DocumentSnapshot) của Firestore sang đối tượng [NotificationModel].
  /// Tự động xử lý giá trị mặc định cho các trường rỗng và chuyển đổi kiểu dữ liệu Firestore Timestamp -> DateTime.
  factory NotificationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NotificationModel(
      id: doc.id,
      title: data['title'] ?? '',
      body: data['body'] ?? '',
      type: data['type'] ?? 'system',
      userId: data['userId'] ?? '',
      isRead: data['isRead'] ?? false,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  /// Chuyển đổi thông tin đối tượng thành dạng Map JSON để ghi trực tiếp lên Cloud Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'body': body,
      'type': type,
      'userId': userId,
      'isRead': isRead,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  /// Chuyển đổi nhanh một thực thể tầng nghiệp vụ [NotificationEntity] sang mô hình dữ liệu tầng dữ liệu [NotificationModel].
  static NotificationModel fromEntity(NotificationEntity entity) {
    return NotificationModel(
      id: entity.id,
      title: entity.title,
      body: entity.body,
      type: entity.type,
      userId: entity.userId,
      isRead: entity.isRead,
      createdAt: entity.createdAt,
    );
  }
}

