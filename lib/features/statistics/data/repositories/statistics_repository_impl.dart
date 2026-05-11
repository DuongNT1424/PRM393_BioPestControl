import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../datasources/statistics_local_data_source.dart';

/// [StatisticsRepositoryImpl] thực thi việc lấy dữ liệu thống kê từ SQLite.
class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsLocalDataSource localDataSource;

  StatisticsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, StatisticsEntity>> getStatistics(String filterType) async {
    try {
      final statistics = await localDataSource.getStatistics(filterType);
      return Right(statistics);
    } catch (e) {
      return const Left(ServerFailure('Lỗi truy xuất dữ liệu từ cơ sở dữ liệu nội bộ'));
    }
  }
}
