import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/notification.dart';
import '../repositories/notification_repository.dart';

/// [SendNotificationUseCase] thực hiện nghiệp vụ gửi một thông báo mới từ Admin/Staff.
/// Nhận vào thực thể [NotificationEntity] và lưu trữ vào Firestore dưới dạng một document mới.
class SendNotificationUseCase implements UseCase<void, NotificationEntity> {
  final NotificationRepository repository;

  SendNotificationUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NotificationEntity notification) async {
    return await repository.sendNotification(notification);
  }
}

