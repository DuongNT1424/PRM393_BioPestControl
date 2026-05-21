import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case lấy chi tiết một tin tức theo ID.
class GetNewsByIdUseCase {
  final NewsRepository repository;

  GetNewsByIdUseCase(this.repository);

  Future<Either<Failure, NewsEntity>> call(String id) {
    return repository.getNewsById(id);
  }
}
