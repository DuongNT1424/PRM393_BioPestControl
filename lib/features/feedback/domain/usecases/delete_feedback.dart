import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import '../repositories/feedback_repository.dart';

class DeleteFeedbackUseCase implements UseCase<void, String> {
  final FeedbackRepository repository;

  DeleteFeedbackUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String feedbackId) {
    return repository.deleteFeedback(feedbackId);
  }
}
