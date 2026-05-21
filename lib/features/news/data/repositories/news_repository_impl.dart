import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/news_entity.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/news_remote_data_source.dart';
import '../models/news_model.dart';

/// [NewsRepositoryImpl] triển khai [NewsRepository] sử dụng Firestore.
class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsList() async {
    try {
      final result = await remoteDataSource.getNewsList();
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không thể tải danh sách tin tức'));
    }
  }

  @override
  Future<Either<Failure, NewsEntity>> getNewsById(String id) async {
    try {
      final result = await remoteDataSource.getNewsById(id);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không tìm thấy tin tức'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> searchNews(String query) async {
    try {
      final result = await remoteDataSource.searchNews(query);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi tìm kiếm tin tức'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> filterNews({
    String? category,
    bool? isPublished,
  }) async {
    try {
      final result = await remoteDataSource.filterNews(
        category: category,
        isPublished: isPublished,
      );
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi lọc tin tức'));
    }
  }

  @override
  Future<Either<Failure, void>> createNews(NewsEntity news) async {
    try {
      final model = NewsModel(
        title: news.title,
        content: news.content,
        summary: news.summary,
        imageUrl: news.imageUrl,
        category: news.category,
        authorId: news.authorId,
        authorName: news.authorName,
        isPublished: news.isPublished,
      );
      await remoteDataSource.createNews(model);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể tạo tin tức mới'));
    }
  }

  @override
  Future<Either<Failure, void>> updateNews(NewsEntity news) async {
    try {
      final model = NewsModel(
        id: news.id,
        title: news.title,
        content: news.content,
        summary: news.summary,
        imageUrl: news.imageUrl,
        category: news.category,
        authorId: news.authorId,
        authorName: news.authorName,
        createdAt: news.createdAt,
        isPublished: news.isPublished,
      );
      await remoteDataSource.updateNews(model);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể cập nhật tin tức'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNews(String id) async {
    try {
      await remoteDataSource.deleteNews(id);
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể xóa tin tức'));
    }
  }
}
