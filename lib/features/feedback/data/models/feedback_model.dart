import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prm393_biopestcontrol/features/feedback/domain/entities/feedback.dart';

class FeedbackModel extends FeedbackEntity {
  const FeedbackModel({
    required super.id,
    required super.customerId,
    required super.customerName,
    required super.customerEmail,
    required super.title,
    required super.content,
    required super.rating,
    required super.status,
    required super.createdAt,
    required super.updatedAt,
    super.replyContent,
    super.replyAuthorId,
    super.replyAuthorName,
    super.repliedAt,
    super.replyUpdatedAt,
    super.productId,
    super.productName,
  });

  factory FeedbackModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return FeedbackModel(
      id: doc.id,
      customerId: data['customerId'] ?? '',
      customerName: data['customerName'] ?? '',
      customerEmail: data['customerEmail'] ?? '',
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      rating: data['rating'] ?? 5,
      status: data['status'] ?? 'pending',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      replyContent: data['replyContent'],
      replyAuthorId: data['replyAuthorId'],
      replyAuthorName: data['replyAuthorName'],
      repliedAt: data['repliedAt'] != null ? (data['repliedAt'] as Timestamp).toDate() : null,
      replyUpdatedAt: data['replyUpdatedAt'] != null ? (data['replyUpdatedAt'] as Timestamp).toDate() : null,
      productId: data['productId'],
      productName: data['productName'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'customerId': customerId,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'title': title,
      'content': content,
      'rating': rating,
      'status': status,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'replyContent': replyContent,
      'replyAuthorId': replyAuthorId,
      'replyAuthorName': replyAuthorName,
      'repliedAt': repliedAt != null ? Timestamp.fromDate(repliedAt!) : null,
      'replyUpdatedAt': replyUpdatedAt != null ? Timestamp.fromDate(replyUpdatedAt!) : null,
      'productId': productId,
      'productName': productName,
    };
  }

  factory FeedbackModel.fromEntity(FeedbackEntity entity) {
    return FeedbackModel(
      id: entity.id,
      customerId: entity.customerId,
      customerName: entity.customerName,
      customerEmail: entity.customerEmail,
      title: entity.title,
      content: entity.content,
      rating: entity.rating,
      status: entity.status,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      replyContent: entity.replyContent,
      replyAuthorId: entity.replyAuthorId,
      replyAuthorName: entity.replyAuthorName,
      repliedAt: entity.repliedAt,
      replyUpdatedAt: entity.replyUpdatedAt,
      productId: entity.productId,
      productName: entity.productName,
    );
  }
}
