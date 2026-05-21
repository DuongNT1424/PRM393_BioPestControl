import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/news_repository.dart';

/// Use case xóa tin tức theo ID.
class DeleteNewsUseCase {
  final NewsRepository repository;

  DeleteNewsUseCase(this.repository);

  Future<Either<Failure, void>> call(String id) {
    return repository.deleteNews(id);
  }
}
