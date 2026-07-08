import 'package:equatable/equatable.dart';
import '../../domain/entities/message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class LoadChatsEvent extends ChatEvent {}

class SearchChatsEvent extends ChatEvent {
  final String query;
  const SearchChatsEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class LoadMessagesEvent extends ChatEvent {
  final String chatId;
  const LoadMessagesEvent(this.chatId);

  @override
  List<Object?> get props => [chatId];
}

class MessagesUpdatedEvent extends ChatEvent {
  final List<MessageEntity> messages;
  const MessagesUpdatedEvent(this.messages);

  @override
  List<Object?> get props => [messages];
}

class MessagesStreamErrorEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String chatId;
  final String customerName;
  final MessageEntity message;
  const SendMessageEvent({
    required this.chatId,
    required this.customerName,
    required this.message,
  });

  @override
  List<Object?> get props => [chatId, customerName, message];
}

class DeleteMessageEvent extends ChatEvent {
  final String chatId;
  final String messageId;
  const DeleteMessageEvent({
    required this.chatId,
    required this.messageId,
  });

  @override
  List<Object?> get props => [chatId, messageId];
}
