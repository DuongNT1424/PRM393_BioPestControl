import 'package:equatable/equatable.dart';
import '../../domain/entities/feedback.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object?> get props => [];
}

class FeedbackInitial extends FeedbackState {}

class FeedbackLoading extends FeedbackState {}

class FeedbackLoaded extends FeedbackState {
  final List<FeedbackEntity> feedbacks;

  const FeedbackLoaded(this.feedbacks);

  @override
  List<Object?> get props => [feedbacks];
}

class FeedbackActionSuccess extends FeedbackState {
  final String message;

  const FeedbackActionSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class FeedbackError extends FeedbackState {
  final String message;

  const FeedbackError(this.message);

  @override
  List<Object?> get props => [message];
}
