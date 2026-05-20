import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/notification.dart';

/// [NotificationRepository] định nghĩa hợp đồng (contract) các hành động xử lý thông báo.
/// Đây là Repository Interface nằm ở tầng Domain, chịu trách nhiệm định nghĩa các hành vi nghiệp vụ
/// mà không quan tâm đến chi tiết triển khai công nghệ (như cách đọc ghi từ Firestore hay CSDL nội bộ).
abstract class NotificationRepository {
  /// Lấy danh sách tất cả thông báo của một người dùng cụ thể.
  /// Phương thức này sẽ kết hợp cả thông báo gửi riêng cho `userId` đó và thông báo gửi chung ('all').
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(String userId);

  /// Đánh dấu một thông báo là đã đọc dựa trên ID của thông báo đó.
  Future<Either<Failure, void>> markAsRead(String notificationId);

  /// Đánh dấu toàn bộ thông báo (bao gồm cá nhân và hệ thống) của một người dùng là đã đọc.
  Future<Either<Failure, void>> markAllAsRead(String userId);

  /// Xóa vĩnh viễn một thông báo ra khỏi hệ thống.
  Future<Either<Failure, void>> deleteNotification(String notificationId);

  /// Gửi (phát) một thông báo mới vào hệ thống (dành cho quản trị viên Admin hoặc nhân viên Staff).
  Future<Either<Failure, void>> sendNotification(NotificationEntity notification);
}
