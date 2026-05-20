import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

/// [DeleteNotificationUseCase] thực hiện nghiệp vụ xóa một thông báo.
/// Đây là lớp UseCase thuộc tầng Domain trong Clean Architecture.
class DeleteNotificationUseCase implements UseCase<void, String> {
  final NotificationRepository repository;

  DeleteNotificationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String notificationId) async {
    return await repository.deleteNotification(notificationId);
  }
}

