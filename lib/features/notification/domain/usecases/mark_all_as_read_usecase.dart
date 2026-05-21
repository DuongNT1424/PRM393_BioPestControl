import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/notification_repository.dart';

/// [MarkAllAsReadUseCase] thực hiện nghiệp vụ đánh dấu toàn bộ thông báo chưa đọc của người dùng thành đã đọc.
/// Thao tác này sẽ áp dụng batch update trên Firestore cho cả thông báo chung và riêng tư.
class MarkAllAsReadUseCase implements UseCase<void, String> {
  final NotificationRepository repository;

  MarkAllAsReadUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String userId) async {
    return await repository.markAllAsRead(userId);
  }
}

