import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case tạo tin tức mới.
class CreateNewsUseCase {
  final NewsRepository repository;

  CreateNewsUseCase(this.repository);

  Future<Either<Failure, void>> call(NewsEntity news) {
    return repository.createNews(news);
  }
}
