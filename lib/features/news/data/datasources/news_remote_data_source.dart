import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/news_model.dart';

/// [NewsRemoteDataSource] định nghĩa các thao tác với Firestore cho tin tức.
abstract class NewsRemoteDataSource {
  Future<List<NewsModel>> getNewsList();
  Future<NewsModel> getNewsById(String id);
  Future<List<NewsModel>> searchNews(String query);
  Future<List<NewsModel>> filterNews({String? category, bool? isPublished});
  Future<void> createNews(NewsModel news);
  Future<void> updateNews(NewsModel news);
  Future<void> deleteNews(String id);
}

/// [NewsRemoteDataSourceImpl] triển khai thao tác với Firestore.
class NewsRemoteDataSourceImpl implements NewsRemoteDataSource {
  final FirebaseFirestore firestore;

  /// Tên collection Firestore cho tin tức.
  static const String _collection = 'news';

  NewsRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<NewsModel>> getNewsList() async {
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => NewsModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<NewsModel> getNewsById(String id) async {
    final doc = await firestore.collection(_collection).doc(id).get();
    if (!doc.exists) {
      throw Exception('Không tìm thấy tin tức với ID: $id');
    }
    return NewsModel.fromFirestore(doc);
  }

  @override
  Future<List<NewsModel>> searchNews(String query) async {
    // Firestore không hỗ trợ full-text search nên tải toàn bộ rồi lọc phía client
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('createdAt', descending: true)
        .get();
    final lowerQuery = query.toLowerCase();
    return snapshot.docs
        .map((doc) => NewsModel.fromMap(doc.data(), doc.id))
        .where((news) =>
            news.title.toLowerCase().contains(lowerQuery) ||
            news.content.toLowerCase().contains(lowerQuery) ||
            (news.summary?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  @override
  Future<List<NewsModel>> filterNews({
    String? category,
    bool? isPublished,
  }) async {
    Query<Map<String, dynamic>> query =
        firestore.collection(_collection).orderBy('createdAt', descending: true);

    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    if (isPublished != null) {
      query = query.where('isPublished', isEqualTo: isPublished);
    }

    final snapshot = await query.get();
    return snapshot.docs
        .map((doc) => NewsModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> createNews(NewsModel news) async {
    await firestore.collection(_collection).add(news.toFirestore());
  }

  @override
  Future<void> updateNews(NewsModel news) async {
    final data = news.toFirestore();
    await firestore.collection(_collection).doc(news.id).update(data);
  }

  @override
  Future<void> deleteNews(String id) async {
    await firestore.collection(_collection).doc(id).delete();
  }
}
