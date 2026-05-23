import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/feedback/domain/entities/feedback.dart';
import 'package:prm393_biopestcontrol/features/feedback/domain/repositories/feedback_repository.dart';
import '../datasources/feedback_remote_data_source.dart';
import '../models/feedback_model.dart';

class FeedbackRepositoryImpl implements FeedbackRepository {
  final FeedbackRemoteDataSource remoteDataSource;

  FeedbackRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<FeedbackEntity>>> getFeedbacks({String? customerId, String? status}) async {
    try {
      final remoteFeedbacks = await remoteDataSource.getFeedbacks(
        customerId: customerId,
        status: status,
      );
      return Right(remoteFeedbacks);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createFeedback(FeedbackEntity feedback) async {
    try {
      final model = FeedbackModel.fromEntity(feedback);
      await remoteDataSource.createFeedback(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateFeedback(FeedbackEntity feedback) async {
    try {
      final model = FeedbackModel.fromEntity(feedback);
      await remoteDataSource.updateFeedback(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteFeedback(String feedbackId) async {
    try {
      await remoteDataSource.deleteFeedback(feedbackId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> replyFeedback({
    required String feedbackId,
    required String replyContent,
    required String authorId,
    required String authorName,
  }) async {
    try {
      await remoteDataSource.replyFeedback(
        feedbackId: feedbackId,
        replyContent: replyContent,
        authorId: authorId,
        authorName: authorName,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
