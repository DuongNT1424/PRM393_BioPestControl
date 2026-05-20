import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// [GetNotificationsUseCase] chịu trách nhiệm lấy toàn bộ danh sách thông báo của người dùng.
/// Nhận vào `userId` (mã người dùng) và trả về danh sách thông báo đã gộp chung và cá nhân,
/// được sắp xếp theo thời gian mới nhất lên đầu.
class GetNotificationsUseCase implements UseCase<List<NotificationEntity>, String> {
  final NotificationRepository repository;

  GetNotificationsUseCase(this.repository);

  @override
  Future<Either<Failure, List<NotificationEntity>>> call(String userId) async {
    return await repository.getNotifications(userId);
  }
}

