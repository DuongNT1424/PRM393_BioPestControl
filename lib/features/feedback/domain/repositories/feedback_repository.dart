import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import '../entities/feedback.dart';

abstract class FeedbackRepository {
  Future<Either<Failure, List<FeedbackEntity>>> getFeedbacks({String? customerId, String? status});
  Future<Either<Failure, void>> createFeedback(FeedbackEntity feedback);
  Future<Either<Failure, void>> updateFeedback(FeedbackEntity feedback);
  Future<Either<Failure, void>> deleteFeedback(String feedbackId);
  Future<Either<Failure, void>> replyFeedback({
    required String feedbackId,
    required String replyContent,
    required String authorId,
    required String authorName,
  });
}
