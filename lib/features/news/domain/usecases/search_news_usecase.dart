import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case tìm kiếm tin tức theo từ khóa.
class SearchNewsUseCase {
  final NewsRepository repository;

  SearchNewsUseCase(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call(String query) {
    return repository.searchNews(query);
  }
}
