import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat.dart';
import '../repositories/chat_repository.dart';

class GetChatsUseCase implements UseCase<List<ChatEntity>, NoParams> {
  final ChatRepository repository;

  GetChatsUseCase(this.repository);

  @override
  Future<Either<Failure, List<ChatEntity>>> call(NoParams params) {
    return repository.getChats();
  }
}
