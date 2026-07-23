import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/statistics_entity.dart';
import '../../domain/repositories/statistics_repository.dart';
import '../datasources/statistics_local_data_source.dart';

/// [StatisticsRepositoryImpl] Lớp triển khai (Implementation) của [StatisticsRepository] ở Data Layer.
/// - Đóng vai trò cầu nối giữa Domain Layer (UseCase) và Data Layer (DataSource).
/// - Gọi đến [StatisticsLocalDataSource] để thực hiện các truy vấn dữ liệu từ Firestore và SQLite.
/// - Xử lý ngoại lệ (Exception) và chuyển hóa chúng thành các mã lỗi nghiệp vụ [Failure].
class StatisticsRepositoryImpl implements StatisticsRepository {
  final StatisticsLocalDataSource localDataSource;

  StatisticsRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, StatisticsEntity>> getStatistics(String filterType) async {
    try {
      // Yêu cầu DataSource truy vấn và tính toán thống kê
      final statistics = await localDataSource.getStatistics(filterType);
      // Trả về dữ liệu thành công cho Domain Layer
      return Right(statistics);
    } catch (e) {
      // Nếu có lỗi trong quá trình truy vấn, trả về ServerFailure
      return const Left(ServerFailure('Lỗi truy xuất dữ liệu từ cơ sở dữ liệu nội bộ/Firebase'));
    }
  }
}
