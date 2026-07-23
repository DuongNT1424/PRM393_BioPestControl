import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/statistics_entity.dart';
import '../repositories/statistics_repository.dart';

/// [GetStatisticsUseCase] Lớp UseCase (Domain Layer) thực hiện nghiệp vụ lấy thống kê doanh thu.
/// - Nhận yêu cầu từ [StatisticsBloc].
/// - Gọi đến [StatisticsRepository] để lấy dữ liệu thực tế từ hệ thống.
/// - Trả về một đối tượng [StatisticsEntity] nếu thành công hoặc lỗi [Failure] nếu thất bại.
class GetStatisticsUseCase {
  final StatisticsRepository repository;

  GetStatisticsUseCase(this.repository);

  /// Phương thức `call` cho phép đối tượng UseCase được sử dụng như một hàm.
  /// `filterType` có thể là 'today', 'week', hoặc 'month'.
  Future<Either<Failure, StatisticsEntity>> call(String filterType) async {
    return await repository.getStatistics(filterType);
  }
}
