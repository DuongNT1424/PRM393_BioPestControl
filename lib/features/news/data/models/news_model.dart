import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/news_entity.dart';

/// [NewsModel] là Data Model chuyển đổi dữ liệu giữa Firestore và NewsEntity.
class NewsModel extends NewsEntity {
  const NewsModel({
    super.id,
    required super.title,
    required super.content,
    super.summary,
    super.imageUrl,
    super.category,
    super.authorId,
    super.authorName,
    super.createdAt,
    super.updatedAt,
    super.isPublished,
  });

  /// Tạo [NewsModel] từ Firestore DocumentSnapshot.
  factory NewsModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return NewsModel(
      id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      summary: data['summary'],
      imageUrl: data['imageUrl'],
      category: data['category'],
      authorId: data['authorId'],
      authorName: data['authorName'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      isPublished: data['isPublished'] ?? true,
    );
  }

  /// Tạo [NewsModel] từ Map (dùng cho QueryDocumentSnapshot).
  factory NewsModel.fromMap(Map<String, dynamic> data, String id) {
    return NewsModel(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      summary: data['summary'],
      imageUrl: data['imageUrl'],
      category: data['category'],
      authorId: data['authorId'],
      authorName: data['authorName'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate(),
      isPublished: data['isPublished'] ?? true,
    );
  }

  /// Chuyển đổi sang Map để lưu lên Firestore.
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'summary': summary,
      'imageUrl': imageUrl,
      'category': category,
      'authorId': authorId,
      'authorName': authorName,
      'createdAt': createdAt != null
          ? Timestamp.fromDate(createdAt!)
          : FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'isPublished': isPublished,
    };
  }
}
