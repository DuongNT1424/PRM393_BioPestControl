import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class SearchChatsUseCase {
  final ChatRepository repository;

  SearchChatsUseCase(this.repository);

  Future<Either<Failure, List<ChatEntity>>> call(String query) {
    return repository.searchChats(query);
  }
}
