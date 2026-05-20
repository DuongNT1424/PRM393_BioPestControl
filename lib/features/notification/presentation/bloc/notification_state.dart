import 'package:equatable/equatable.dart';
import '../../domain/entities/notification.dart';

/// [NotificationState] định nghĩa lớp trạng thái cơ sở cho BLoC Thông báo.
abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

/// Trạng thái khởi tạo ban đầu khi BLoC được tạo dựng.
class NotificationInitial extends NotificationState {}

/// Trạng thái đang tải dữ liệu thông báo hoặc đang thực thi các tác vụ xử lý thông báo.
class NotificationLoading extends NotificationState {}

/// Trạng thái tải thành công danh sách thông báo. Chứa dữ liệu danh sách `notifications`.
class NotificationLoaded extends NotificationState {
  final List<NotificationEntity> notifications;
  const NotificationLoaded(this.notifications);

  @override
  List<Object?> get props => [notifications];
}

/// Trạng thái gặp lỗi trong quá trình thực thi nghiệp vụ thông báo. Chứa thông báo lỗi `message`.
class NotificationError extends NotificationState {
  final String message;
  const NotificationError(this.message);

  @override
  List<Object?> get props => [message];
}

/// Trạng thái thực hiện thành công các thao tác đặc thù (như đánh dấu đã đọc, xóa hoặc gửi thông báo thành công).
class NotificationActionSuccess extends NotificationState {
  final String message;
  const NotificationActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

