import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_notifications.dart';
import '../../domain/usecases/mark_as_read_usecase.dart';
import '../../domain/usecases/mark_all_as_read_usecase.dart';
import '../../domain/usecases/delete_notification_usecase.dart';
import '../../domain/usecases/send_notification_usecase.dart';
import 'notification_event.dart';
import 'notification_state.dart';

/// [NotificationBloc] quản lý vòng đời trạng thái của các tính năng thông báo.
/// Phối hợp các Use Case nghiệp vụ từ tầng Domain và phát tín hiệu trạng thái tương ứng ra UI.
/// Tự động bắt giữ thông tin `_currentUserId` để tự động làm mới danh sách (auto-reload) sau các hành động ghi.
class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final GetNotificationsUseCase getNotificationsUseCase;
  final MarkAsReadUseCase markAsReadUseCase;
  final MarkAllAsReadUseCase markAllAsReadUseCase;
  final DeleteNotificationUseCase deleteNotificationUseCase;
  final SendNotificationUseCase sendNotificationUseCase;

  /// Lưu trữ ID của người dùng hiện tại để thực hiện tải lại tự động.
  String? _currentUserId;

  NotificationBloc({
    required this.getNotificationsUseCase,
    required this.markAsReadUseCase,
    required this.markAllAsReadUseCase,
    required this.deleteNotificationUseCase,
    required this.sendNotificationUseCase,
  }) : super(NotificationInitial()) {
    on<LoadNotificationsEvent>(_onLoadNotifications);
    on<MarkAsReadEvent>(_onMarkAsRead);
    on<MarkAllAsReadEvent>(_onMarkAllAsRead);
    on<DeleteNotificationEvent>(_onDeleteNotification);
    on<SendNotificationEvent>(_onSendNotification);
  }

  /// Xử lý tải danh sách thông báo.
  Future<void> _onLoadNotifications(LoadNotificationsEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    _currentUserId = event.userId;
    final result = await getNotificationsUseCase(event.userId);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (notifications) => emit(NotificationLoaded(notifications)),
    );
  }

  /// Xử lý đánh dấu một thông báo là đã đọc và tự động làm mới danh sách.
  Future<void> _onMarkAsRead(MarkAsReadEvent event, Emitter<NotificationState> emit) async {
    final result = await markAsReadUseCase(event.notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        emit(const NotificationActionSuccess('Đã đánh dấu thông báo là đã đọc'));
        if (_currentUserId != null) {
          add(LoadNotificationsEvent(_currentUserId!));
        }
      },
    );
  }

  /// Xử lý đánh dấu tất cả thông báo là đã đọc và tự động làm mới danh sách.
  Future<void> _onMarkAllAsRead(MarkAllAsReadEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await markAllAsReadUseCase(event.userId);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        emit(const NotificationActionSuccess('Đã đánh dấu tất cả thông báo là đã đọc'));
        add(LoadNotificationsEvent(event.userId));
      },
    );
  }

  /// Xử lý xóa thông báo và tự động làm mới danh sách.
  Future<void> _onDeleteNotification(DeleteNotificationEvent event, Emitter<NotificationState> emit) async {
    final result = await deleteNotificationUseCase(event.notificationId);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        emit(const NotificationActionSuccess('Xóa thông báo thành công'));
        if (_currentUserId != null) {
          add(LoadNotificationsEvent(_currentUserId!));
        }
      },
    );
  }

  /// Xử lý gửi thông báo mới của Admin/Staff và tự động làm mới danh sách của họ nếu cần.
  Future<void> _onSendNotification(SendNotificationEvent event, Emitter<NotificationState> emit) async {
    emit(NotificationLoading());
    final result = await sendNotificationUseCase(event.notification);
    result.fold(
      (failure) => emit(NotificationError(failure.message)),
      (_) {
        emit(const NotificationActionSuccess('Gửi thông báo thành công'));
        if (_currentUserId != null) {
          add(LoadNotificationsEvent(_currentUserId!));
        }
      },
    );
  }
}

