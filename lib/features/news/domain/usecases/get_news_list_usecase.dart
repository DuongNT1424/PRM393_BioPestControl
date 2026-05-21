import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/news_entity.dart';
import '../repositories/news_repository.dart';

/// Use case lấy danh sách tất cả tin tức.
class GetNewsListUseCase implements UseCase<List<NewsEntity>, NoParams> {
  final NewsRepository repository;

  GetNewsListUseCase(this.repository);

  @override
  Future<Either<Failure, List<NewsEntity>>> call(NoParams params) {
    return repository.getNewsList();
  }
}
