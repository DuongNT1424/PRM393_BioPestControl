import 'package:equatable/equatable.dart';

abstract class StatisticsEvent extends Equatable {
  const StatisticsEvent();

  @override
  List<Object?> get props => [];
}

/// Sự kiện tải dữ liệu thống kê với bộ lọc.
class LoadStatisticsEvent extends StatisticsEvent {
  final String filterType;

  const LoadStatisticsEvent({this.filterType = 'month'});

  @override
  List<Object?> get props => [filterType];
}
