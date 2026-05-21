import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case cập nhật tin tức.
class UpdateNewsUseCase {
  final NewsRepository repository;

  UpdateNewsUseCase(this.repository);

  Future<Either<Failure, void>> call(NewsEntity news) {
    return repository.updateNews(news);
  }
}
