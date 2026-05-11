import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/statistics_entity.dart';
import '../repositories/statistics_repository.dart';

/// [GetStatisticsUseCase] thực hiện nghiệp vụ lấy thống kê.
class GetStatisticsUseCase {
  final StatisticsRepository repository;

  GetStatisticsUseCase(this.repository);

  Future<Either<Failure, StatisticsEntity>> call(String filterType) async {
    return await repository.getStatistics(filterType);
  }
}
