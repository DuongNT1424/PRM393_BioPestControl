import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/chat.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/chat_remote_data_source.dart';
import '../models/message_model.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<ChatEntity>>> getChats() async {
    try {
      final result = await remoteDataSource.getChats();
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Không thể tải danh sách hộp thoại'));
    }
  }

  @override
  Future<Either<Failure, List<ChatEntity>>> searchChats(String query) async {
    try {
      final result = await remoteDataSource.searchChats(query);
      return Right(result);
    } catch (e) {
      return const Left(ServerFailure('Lỗi khi tìm kiếm hộp thoại'));
    }
  }

  @override
  Stream<List<MessageEntity>> getMessages(String chatId) {
    return remoteDataSource.getMessages(chatId);
  }

  @override
  Future<Either<Failure, void>> sendMessage({
    required String chatId,
    required String customerName,
    required MessageEntity message,
  }) async {
    try {
      final model = MessageModel(
        senderId: message.senderId,
        senderName: message.senderName,
        senderRole: message.senderRole,
        text: message.text,
      );
      await remoteDataSource.sendMessage(
        chatId: chatId,
        customerName: customerName,
        message: model,
      );
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể gửi tin nhắn'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    try {
      await remoteDataSource.deleteMessage(
        chatId: chatId,
        messageId: messageId,
      );
      return const Right(null);
    } catch (e) {
      return const Left(ServerFailure('Không thể xóa tin nhắn'));
    }
  }
}
