import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

/// [MarkAsReadUseCase] thực hiện nghiệp vụ đánh dấu một thông báo cụ thể là đã đọc.
/// Nhận vào `notificationId` và cập nhật trường `isRead` của document đó trên Firestore thành true.
class MarkAsReadUseCase implements UseCase<void, String> {
  final NotificationRepository repository;

  MarkAsReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String notificationId) async {
    return await repository.markAsRead(notificationId);
  }
}

