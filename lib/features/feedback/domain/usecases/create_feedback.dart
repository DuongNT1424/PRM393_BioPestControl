import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import '../entities/feedback.dart';
import '../repositories/feedback_repository.dart';

class CreateFeedbackUseCase implements UseCase<void, FeedbackEntity> {
  final FeedbackRepository repository;

  CreateFeedbackUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(FeedbackEntity feedback) {
    return repository.createFeedback(feedback);
  }
}
