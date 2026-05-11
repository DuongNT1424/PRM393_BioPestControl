import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/statistics_entity.dart';

/// [StatisticsRepository] định nghĩa các phương thức giao tiếp với dữ liệu thống kê.
abstract class StatisticsRepository {
  /// Lấy dữ liệu thống kê dựa trên khoảng thời gian lọc.
  /// 
  /// [filterType] có thể là: 'today', 'week', 'month', 'year'.
  Future<Either<Failure, StatisticsEntity>> getStatistics(String filterType);
}
