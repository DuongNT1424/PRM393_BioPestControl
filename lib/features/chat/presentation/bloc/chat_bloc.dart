import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/message.dart';
import '../../domain/usecases/get_chats.dart';
import '../../domain/usecases/search_chats.dart';
import '../../domain/usecases/get_messages.dart';
import '../../domain/usecases/send_message.dart';
import '../../domain/usecases/delete_message.dart';
import '../../../../core/usecases/usecase.dart';
import 'chat_event.dart';
import 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatsUseCase getChatsUseCase;
  final SearchChatsUseCase searchChatsUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final SendMessageUseCase sendMessageUseCase;
  final DeleteMessageUseCase deleteMessageUseCase;

  StreamSubscription<List<MessageEntity>>? _messagesSubscription;

  ChatBloc({
    required this.getChatsUseCase,
    required this.searchChatsUseCase,
    required this.getMessagesUseCase,
    required this.sendMessageUseCase,
    required this.deleteMessageUseCase,
  }) : super(ChatInitial()) {
    on<LoadChatsEvent>(_onLoadChats);
    on<SearchChatsEvent>(_onSearchChats);
    on<LoadMessagesEvent>(_onLoadMessages);
    on<MessagesUpdatedEvent>(_onMessagesUpdated);
    on<MessagesStreamErrorEvent>(_onMessagesStreamError);
    on<SendMessageEvent>(_onSendMessage);
    on<DeleteMessageEvent>(_onDeleteMessage);
  }

  Future<void> _onLoadChats(
      LoadChatsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await getChatsUseCase(NoParams());
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chats) => emit(ChatsLoaded(chats)),
    );
  }

  Future<void> _onSearchChats(
      SearchChatsEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    final result = await searchChatsUseCase(event.query);
    result.fold(
      (failure) => emit(ChatError(failure.message)),
      (chats) => emit(ChatsLoaded(chats)),
    );
  }

  void _onLoadMessages(LoadMessagesEvent event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    _messagesSubscription?.cancel();
    _messagesSubscription = getMessagesUseCase(event.chatId).listen(
      (messages) => add(MessagesUpdatedEvent(messages)),
      onError: (_) => add(MessagesStreamErrorEvent()),
    );
  }

  void _onMessagesUpdated(
      MessagesUpdatedEvent event, Emitter<ChatState> emit) {
    emit(MessagesLoaded(event.messages));
  }

  void _onMessagesStreamError(
      MessagesStreamErrorEvent event, Emitter<ChatState> emit) {
    emit(const ChatError('Không thể tải tin nhắn'));
  }

  Future<void> _onSendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    final result = await sendMessageUseCase(SendMessageParams(
      chatId: event.chatId,
      customerName: event.customerName,
      message: event.message,
    ));
    result.fold(
      (failure) => emit(ChatActionFailure(failure.message)),
      (_) {},
    );
  }

  Future<void> _onDeleteMessage(
      DeleteMessageEvent event, Emitter<ChatState> emit) async {
    final result = await deleteMessageUseCase(DeleteMessageParams(
      chatId: event.chatId,
      messageId: event.messageId,
    ));
    result.fold(
      (failure) => emit(ChatActionFailure(failure.message)),
      (_) {},
    );
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
