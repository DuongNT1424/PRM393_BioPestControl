import 'package:equatable/equatable.dart';

/// [NewsEntity] là entity trung tâm của tính năng Tin tức/Bài viết.
class NewsEntity extends Equatable {
  final String? id;
  final String title;
  final String content;
  final String? summary;
  final String? imageUrl;
  final String? category; // e.g. 'Tin tức', 'Khuyến mãi', 'Hướng dẫn'
  final String? authorId;
  final String? authorName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool isPublished;

  const NewsEntity({
    this.id,
    required this.title,
    required this.content,
    this.summary,
    this.imageUrl,
    this.category,
    this.authorId,
    this.authorName,
    this.createdAt,
    this.updatedAt,
    this.isPublished = true,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        summary,
        imageUrl,
        category,
        authorId,
        authorName,
        createdAt,
        updatedAt,
        isPublished,
      ];
}
