import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import '../entities/feedback.dart';
import '../repositories/feedback_repository.dart';

class GetFeedbacksParams {
  final String? customerId;
  final String? status;

  const GetFeedbacksParams({this.customerId, this.status});
}

class GetFeedbacksUseCase implements UseCase<List<FeedbackEntity>, GetFeedbacksParams> {
  final FeedbackRepository repository;

  GetFeedbacksUseCase(this.repository);

  @override
  Future<Either<Failure, List<FeedbackEntity>>> call(GetFeedbacksParams params) {
    return repository.getFeedbacks(
      customerId: params.customerId,
      status: params.status,
    );
  }
}
