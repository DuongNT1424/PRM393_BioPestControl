import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../entities/message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatEntity>>> getChats();

  Future<Either<Failure, List<ChatEntity>>> searchChats(String query);

  Stream<List<MessageEntity>> getMessages(String chatId);

  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String customerName,
    required MessageEntity message,
  });

  Future<Either<Failure, void>> deleteMessage({
    required String chatId,
    required String messageId,
  });
}
