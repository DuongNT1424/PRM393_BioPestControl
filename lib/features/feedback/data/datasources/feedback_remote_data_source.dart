import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/feedback_model.dart';

abstract class FeedbackRemoteDataSource {
  Future<List<FeedbackModel>> getFeedbacks({String? customerId, String? status});
  Future<void> createFeedback(FeedbackModel feedback);
  Future<void> updateFeedback(FeedbackModel feedback);
  Future<void> deleteFeedback(String feedbackId);
  Future<void> replyFeedback({
    required String feedbackId,
    required String replyContent,
    required String authorId,
    required String authorName,
  });
}

class FeedbackRemoteDataSourceImpl implements FeedbackRemoteDataSource {
  final FirebaseFirestore firestore;

  FeedbackRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<FeedbackModel>> getFeedbacks({String? customerId, String? status}) async {
    Query query = firestore.collection('feedbacks');

    if (customerId != null && customerId.isNotEmpty) {
      query = query.where('customerId', isEqualTo: customerId);
    }
    
    if (status != null && status.isNotEmpty) {
      query = query.where('status', isEqualTo: status);
    }

    final snapshot = await query.get();
    
    final feedbacksList = snapshot.docs
        .map((doc) => FeedbackModel.fromFirestore(doc))
        .toList();

    // Sắp xếp in-memory trong Dart theo thời gian tạo giảm dần (mới nhất lên đầu)
    feedbacksList.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return feedbacksList;
  }

  @override
  Future<void> createFeedback(FeedbackModel feedback) async {
    // Để Firestore tự động tạo ID ngẫu nhiên cho doc
    final docRef = firestore.collection('feedbacks').doc();
    final data = feedback.toFirestore();
    // Ghi nhận id tự sinh của Document vào trường trong data nếu cần, 
    // nhưng ở đây we will just set the data directly.
    await docRef.set(data);
  }

  @override
  Future<void> updateFeedback(FeedbackModel feedback) async {
    await firestore
        .collection('feedbacks')
        .doc(feedback.id)
        .update(feedback.toFirestore());
  }

  @override
  Future<void> deleteFeedback(String feedbackId) async {
    await firestore.collection('feedbacks').doc(feedbackId).delete();
  }

  @override
  Future<void> replyFeedback({
    required String feedbackId,
    required String replyContent,
    required String authorId,
    required String authorName,
  }) async {
    final now = DateTime.now();
    await firestore.collection('feedbacks').doc(feedbackId).update({
      'replyContent': replyContent,
      'replyAuthorId': authorId,
      'replyAuthorName': authorName,
      'status': 'replied',
      'repliedAt': Timestamp.fromDate(now),
      'replyUpdatedAt': Timestamp.fromDate(now),
    });
  }
}
