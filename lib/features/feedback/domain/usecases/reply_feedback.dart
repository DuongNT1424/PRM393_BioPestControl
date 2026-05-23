import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import '../repositories/feedback_repository.dart';

class ReplyFeedbackParams {
  final String feedbackId;
  final String replyContent;
  final String authorId;
  final String authorName;

  const ReplyFeedbackParams({
    required this.feedbackId,
    required this.replyContent,
    required this.authorId,
    required this.authorName,
  });
}

class ReplyFeedbackUseCase implements UseCase<void, ReplyFeedbackParams> {
  final FeedbackRepository repository;

  ReplyFeedbackUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ReplyFeedbackParams params) {
    return repository.replyFeedback(
      feedbackId: params.feedbackId,
      replyContent: params.replyContent,
      authorId: params.authorId,
      authorName: params.authorName,
    );
  }
}
