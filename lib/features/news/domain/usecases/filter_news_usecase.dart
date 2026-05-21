import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Params cho FilterNewsUseCase.
class FilterNewsParams {
  final String? category;
  final bool? isPublished;

  const FilterNewsParams({this.category, this.isPublished});
}

/// Use case lọc tin tức theo danh mục và/hoặc trạng thái.
class FilterNewsUseCase {
  final NewsRepository repository;

  FilterNewsUseCase(this.repository);

  Future<Either<Failure, List<NewsEntity>>> call(FilterNewsParams params) {
    return repository.filterNews(
      category: params.category,
      isPublished: params.isPublished,
    );
  }
}
