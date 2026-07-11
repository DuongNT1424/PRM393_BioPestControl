import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/chat_repository.dart';

class DeleteMessageParams {
  final String chatId;
  final String messageId;

  const DeleteMessageParams({
    required this.chatId,
    required this.messageId,
  });
}

class DeleteMessageUseCase {
  final ChatRepository repository;

  DeleteMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(DeleteMessageParams params) {
    return repository.deleteMessage(
      chatId: params.chatId,
      messageId: params.messageId,
    );
  }
}
