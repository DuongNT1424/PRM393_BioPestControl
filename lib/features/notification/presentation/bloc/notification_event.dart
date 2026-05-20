import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

/// [NotificationEvent] định nghĩa lớp sự kiện cơ sở cho BLoC Thông báo.
abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object?> get props => [];
}

/// [LoadNotificationsEvent] yêu cầu BLoC tải toàn bộ danh sách thông báo của người dùng `userId`.
class LoadNotificationsEvent extends NotificationEvent {
  final String userId;
  const LoadNotificationsEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// [MarkAsReadEvent] yêu cầu đánh dấu một thông báo duy nhất là đã đọc.
class MarkAsReadEvent extends NotificationEvent {
  final String notificationId;
  const MarkAsReadEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

/// [MarkAllAsReadEvent] yêu cầu đánh dấu toàn bộ thông báo chưa đọc của user thành đã đọc.
class MarkAllAsReadEvent extends NotificationEvent {
  final String userId;
  const MarkAllAsReadEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// [DeleteNotificationEvent] yêu cầu xóa một thông báo cụ thể ra khỏi hệ thống.
class DeleteNotificationEvent extends NotificationEvent {
  final String notificationId;
  const DeleteNotificationEvent(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}

/// [SendNotificationEvent] yêu cầu gửi một thông báo mới từ phía quản trị viên.
class SendNotificationEvent extends NotificationEvent {
  final NotificationEntity notification;
  const SendNotificationEvent(this.notification);

  @override
  List<Object?> get props => [notification];
}

