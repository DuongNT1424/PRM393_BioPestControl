import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_feedbacks.dart';
import '../../domain/usecases/create_feedback.dart';
import '../../domain/usecases/update_feedback.dart';
import '../../domain/usecases/delete_feedback.dart';
import '../../domain/usecases/reply_feedback.dart';
import 'feedback_event.dart';
import 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final GetFeedbacksUseCase getFeedbacksUseCase;
  final CreateFeedbackUseCase createFeedbackUseCase;
  final UpdateFeedbackUseCase updateFeedbackUseCase;
  final DeleteFeedbackUseCase deleteFeedbackUseCase;
  final ReplyFeedbackUseCase replyFeedbackUseCase;

  FeedbackBloc({
    required this.getFeedbacksUseCase,
    required this.createFeedbackUseCase,
    required this.updateFeedbackUseCase,
    required this.deleteFeedbackUseCase,
    required this.replyFeedbackUseCase,
  }) : super(FeedbackInitial()) {
    on<LoadFeedbacksEvent>(_onLoadFeedbacks);
    on<CreateFeedbackEvent>(_onCreateFeedback);
    on<UpdateFeedbackEvent>(_onUpdateFeedback);
    on<DeleteFeedbackEvent>(_onDeleteFeedback);
    on<ReplyFeedbackEvent>(_onReplyFeedback);
  }

  Future<void> _onLoadFeedbacks(
    LoadFeedbacksEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    final result = await getFeedbacksUseCase(
      GetFeedbacksParams(customerId: event.customerId, status: event.status),
    );
    result.fold(
      (failure) => emit(FeedbackError(failure.message)),
      (feedbacks) => emit(FeedbackLoaded(feedbacks)),
    );
  }

  Future<void> _onCreateFeedback(
    CreateFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    final result = await createFeedbackUseCase(event.feedback);
    result.fold(
      (failure) => emit(FeedbackError(failure.message)),
      (_) => emit(const FeedbackActionSuccess('Đã gửi ý kiến phản hồi thành công!')),
    );
  }

  Future<void> _onUpdateFeedback(
    UpdateFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    final result = await updateFeedbackUseCase(event.feedback);
    result.fold(
      (failure) => emit(FeedbackError(failure.message)),
      (_) => emit(const FeedbackActionSuccess('Đã cập nhật ý kiến phản hồi thành công!')),
    );
  }

  Future<void> _onDeleteFeedback(
    DeleteFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    final result = await deleteFeedbackUseCase(event.feedbackId);
    result.fold(
      (failure) => emit(FeedbackError(failure.message)),
      (_) => emit(const FeedbackActionSuccess('Đã xóa ý kiến phản hồi thành công!')),
    );
  }

  Future<void> _onReplyFeedback(
    ReplyFeedbackEvent event,
    Emitter<FeedbackState> emit,
  ) async {
    emit(FeedbackLoading());
    final result = await replyFeedbackUseCase(
      ReplyFeedbackParams(
        feedbackId: event.feedbackId,
        replyContent: event.replyContent,
        authorId: event.authorId,
        authorName: event.authorName,
      ),
    );
    result.fold(
      (failure) => emit(FeedbackError(failure.message)),
      (_) => emit(const FeedbackActionSuccess('Đã gửi phản hồi ý kiến thành công!')),
    );
  }
}
