import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/notification.dart';
import '../../domain/repositories/notification_repository.dart';
import '../datasources/notification_remote_data_source.dart';
import '../models/notification_model.dart';

/// [NotificationRepositoryImpl] triển khai cụ thể của giao diện [NotificationRepository].
/// Nằm ở tầng Data của Clean Architecture, chịu trách nhiệm phối hợp nguồn dữ liệu từ xa (RemoteDataSource)
/// và xử lý mọi ngoại lệ xảy ra (ví dụ: mất mạng, lỗi quyền Firestore) bằng cách chuyển đổi chúng
/// thành các đối tượng [Failure] cụ thể để chuyển tiếp về tầng Presentation thông qua [Either].
class NotificationRepositoryImpl implements NotificationRepository {
  final NotificationRemoteDataSource remoteDataSource;

  NotificationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications(String userId) async {
    try {
      final notifications = await remoteDataSource.getNotifications(userId);
      return Right(notifications);
    } catch (e) {
      return Left(ServerFailure('Lấy danh sách thông báo thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(String notificationId) async {
    try {
      await remoteDataSource.markAsRead(notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Đánh dấu đã đọc thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> markAllAsRead(String userId) async {
    try {
      await remoteDataSource.markAllAsRead(userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Đánh dấu đọc tất cả thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNotification(String notificationId) async {
    try {
      await remoteDataSource.deleteNotification(notificationId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Xóa thông báo thất bại: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> sendNotification(NotificationEntity notification) async {
    try {
      final model = NotificationModel.fromEntity(notification);
      await remoteDataSource.sendNotification(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Gửi thông báo thất bại: ${e.toString()}'));
    }
  }
}

