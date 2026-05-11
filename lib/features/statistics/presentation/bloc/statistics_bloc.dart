import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_statistics_usecase.dart';
import 'statistics_event.dart';
import 'statistics_state.dart';

class StatisticsBloc extends Bloc<StatisticsEvent, StatisticsState> {
  final GetStatisticsUseCase getStatisticsUseCase;

  StatisticsBloc({required this.getStatisticsUseCase}) : super(StatisticsInitial()) {
    on<LoadStatisticsEvent>((event, emit) async {
      emit(StatisticsLoading());
      
      final result = await getStatisticsUseCase(event.filterType);
      
      result.fold(
        (failure) => emit(const StatisticsError('Không thể tải dữ liệu thống kê')),
        (statistics) => emit(StatisticsLoaded(statistics, event.filterType)),
      );
    });
  }
}
