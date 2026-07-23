import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_statistics_usecase.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

/// [StatisticsBloc] Quản lý trạng thái cho chức năng Thống kê doanh thu (Manage Revenue).
/// - Nhận sự kiện (Events) như yêu cầu tải dữ liệu thống kê từ UI (ví dụ: ManagementPage).
/// - Gọi đến [GetStatisticsUseCase] ở tầng Domain để xử lý.
/// - Phát ra (Emit) các trạng thái (Loading, Loaded, Error) để UI tự động cập nhật giao diện biểu đồ/số liệu.
class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  // UseCase được tiêm vào (Dependency Injection)
  final GetStatisticsUseCase getStatisticsUseCase;

  StatisticsBloc({required this.getStatisticsUseCase}) : super(StatisticsInitial()) {
    // Đăng ký xử lý sự kiện LoadStatisticsEvent
    on<LoadStatisticsEvent>((event, emit) async {
      // 1. Báo cho UI biết đang tải dữ liệu
      emit(StatisticsLoading());
      
      // 2. Gọi UseCase thực thi logic lấy thống kê theo bộ lọc (today, week, month)
      final result = await getStatisticsUseCase(event.filterType);
      
      // 3. Phân tích kết quả Either (Right: Thành công, Left: Thất bại) và báo về UI
      result.fold(
        (failure) => emit(const StatisticsError('Không thể tải dữ liệu thống kê')),
        (statistics) => emit(StatisticsLoaded(statistics, event.filterType)),
      );
    });
  }
}
