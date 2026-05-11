import 'package:equatable/equatable.dart';
import '../../domain/entities/statistics_entity.dart';

abstract class StatisticsState extends Equatable {
  const StatisticsState();
  
  @override
  List<Object?> get props => [];
}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsLoaded extends StatisticsState {
  final StatisticsEntity statistics;
  final String currentFilter;

  const StatisticsLoaded(this.statistics, this.currentFilter);

  @override
  List<Object?> get props => [statistics, currentFilter];
}

class StatisticsError extends StatisticsState {
  final String message;

  const StatisticsError(this.message);

  @override
  List<Object?> get props => [message];
}
