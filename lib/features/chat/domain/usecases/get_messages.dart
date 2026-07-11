import '../entities/message.dart';
import '../repositories/chat_repository.dart';

class GetMessagesUseCase {
  final ChatRepository repository;

  GetMessagesUseCase(this.repository);

  Stream<List<MessageEntity>> call(String chatId) {
    return repository.getMessages(chatId);
  }
}
