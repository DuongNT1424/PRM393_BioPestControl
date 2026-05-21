import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';

/// [NewsRepository] định nghĩa các hành động cho tính năng Tin tức/Bài viết.
abstract class NewsRepository {
  /// Lấy danh sách tất cả tin tức.
  Future<Either<Failure, List<NewsEntity>>> getNewsList();

  /// Lấy chi tiết một tin tức theo ID.
  Future<Either<Failure, NewsEntity>> getNewsById(String id);

  /// Tìm kiếm tin tức theo tiêu đề hoặc nội dung.
  Future<Either<Failure, List<NewsEntity>>> searchNews(String query);

  /// Lọc tin tức theo danh mục và/hoặc trạng thái published.
  Future<Either<Failure, List<NewsEntity>>> filterNews({
    String? category,
    bool? isPublished,
  });

  /// Tạo tin tức mới.
  Future<Either<Failure, void>> createNews(NewsEntity news);

  /// Cập nhật tin tức.
  Future<Either<Failure, void>> updateNews(NewsEntity news);

  /// Xóa tin tức.
  Future<Either<Failure, void>> deleteNews(String id);
}
