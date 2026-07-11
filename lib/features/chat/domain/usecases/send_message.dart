import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class SendMessageParams {
  final String chatId;
  final String customerName;
  final MessageEntity message;

  const SendMessageParams({
    required this.chatId,
    required this.customerName,
    required this.message,
  });
}

class SendMessageUseCase {
  final ChatRepository repository;

  SendMessageUseCase(this.repository);

  Future<Either<Failure, void>> call(SendMessageParams params) {
    return repository.sendMessage(
      chatId: params.chatId,
      customerName: params.customerName,
      message: params.message,
    );
  }
}
