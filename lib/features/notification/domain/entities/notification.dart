import 'package:equatable/equatable.dart';

/// [NotificationEntity] đại diện cho một thông báo trong hệ thống.
/// Đây là lớp thực thể cốt lõi (Core Entity) trong tầng Domain của Clean Architecture.
class NotificationEntity extends Equatable {
  /// Mã định danh duy nhất của thông báo trên Firestore.
  final String id;

  /// Tiêu đề hiển thị của thông báo.
  final String title;

  /// Nội dung chi tiết của thông báo.
  final String body;

  /// Phân loại thông báo: 'order' (Đơn hàng), 'discount' (Ưu đãi), 'system' (Hệ thống), 'expert' (Chuyên gia).
  final String type; 

  /// Mã định danh của người nhận thông báo.
  /// Nếu gửi cho tất cả người dùng, trường này sẽ có giá trị là 'all'.
  final String userId; 

  /// Trạng thái đã đọc/chưa đọc của thông báo.
  final bool isRead;

  /// Thời điểm thông báo được tạo ra.
  final DateTime createdAt;

  const NotificationEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.type,
    required this.userId,
    required this.isRead,
    required this.createdAt,
  });

  /// Tạo một bản sao mới của [NotificationEntity] nhưng thay đổi một vài thuộc tính nhất định.
  /// Rất hữu ích khi cần cập nhật trạng thái `isRead` mà không làm thay đổi các trường dữ liệu khác.
  NotificationEntity copyWith({
    String? id,
    String? title,
    String? body,
    String? type,
    String? userId,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
      type: type ?? this.type,
      userId: userId ?? this.userId,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, title, body, type, userId, isRead, createdAt];
}

