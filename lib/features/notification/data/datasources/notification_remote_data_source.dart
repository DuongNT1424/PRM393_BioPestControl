import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/notification_model.dart';

abstract class NotificationRemoteDataSource {
  Future<List<NotificationModel>> getNotifications(String userId);
  Future<void> markAsRead(String notificationId);
  Future<void> markAllAsRead(String userId);
  Future<void> deleteNotification(String notificationId);
  Future<void> sendNotification(NotificationModel notification);
}

class NotificationRemoteDataSourceImpl implements NotificationRemoteDataSource {
  final FirebaseFirestore firestore;

  NotificationRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<NotificationModel>> getNotifications(String userId) async {
    // 1. Lấy thông báo cá nhân
    final userSnapshot = await firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .get();

    // 2. Lấy thông báo chung hệ thống ('all')
    final globalSnapshot = await firestore
        .collection('notifications')
        .where('userId', isEqualTo: 'all')
        .get();

    // Gộp 2 danh sách lại
    final List<NotificationModel> notifications = [];
    
    for (var doc in userSnapshot.docs) {
      notifications.add(NotificationModel.fromFirestore(doc));
    }
    
    for (var doc in globalSnapshot.docs) {
      // Tránh trùng lặp id
      if (!notifications.any((element) => element.id == doc.id)) {
        notifications.add(NotificationModel.fromFirestore(doc));
      }
    }

    // Sắp xếp theo ngày tạo giảm dần (mới nhất lên đầu)
    notifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return notifications;
  }

  @override
  Future<void> markAsRead(String notificationId) async {
    await firestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  @override
  Future<void> markAllAsRead(String userId) async {
    // Tìm các thông báo chưa đọc của user này
    final userUnreadDocs = await firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .where('isRead', isEqualTo: false)
        .get();

    // Tìm các thông báo chưa đọc toàn hệ thống
    final globalUnreadDocs = await firestore
        .collection('notifications')
        .where('userId', isEqualTo: 'all')
        .where('isRead', isEqualTo: false)
        .get();

    final batch = firestore.batch();

    for (var doc in userUnreadDocs.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    for (var doc in globalUnreadDocs.docs) {
      batch.update(doc.reference, {'isRead': true});
    }

    await batch.commit();
  }

  @override
  Future<void> deleteNotification(String notificationId) async {
    await firestore.collection('notifications').doc(notificationId).delete();
  }

  @override
  Future<void> sendNotification(NotificationModel notification) async {
    await firestore.collection('notifications').add(notification.toFirestore());
  }
}
