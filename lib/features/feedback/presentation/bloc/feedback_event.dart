import 'package:equatable/equatable.dart';
import '../../domain/entities/feedback.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}

class LoadFeedbacksEvent extends FeedbackEvent {
  final String? customerId;
  final String? status;

  const LoadFeedbacksEvent({this.customerId, this.status});

  @override
  List<Object?> get props => [customerId, status];
}

class CreateFeedbackEvent extends FeedbackEvent {
  final FeedbackEntity feedback;

  const CreateFeedbackEvent(this.feedback);

  @override
  List<Object?> get props => [feedback];
}

class UpdateFeedbackEvent extends FeedbackEvent {
  final FeedbackEntity feedback;

  const UpdateFeedbackEvent(this.feedback);

  @override
  List<Object?> get props => [feedback];
}

class DeleteFeedbackEvent extends FeedbackEvent {
  final String feedbackId;

  const DeleteFeedbackEvent(this.feedbackId);

  @override
  List<Object?> get props => [feedbackId];
}

class ReplyFeedbackEvent extends FeedbackEvent {
  final String feedbackId;
  final String replyContent;
  final String authorId;
  final String authorName;

  const ReplyFeedbackEvent({
    required this.feedbackId,
    required this.replyContent,
    required this.authorId,
    required this.authorName,
  });

  @override
  List<Object?> get props => [feedbackId, replyContent, authorId, authorName];
}
