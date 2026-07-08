import 'package:equatable/equatable.dart';

class ChatEntity extends Equatable {
  final String id;
  final String customerId;
  final String customerName;
  final String? lastMessage;
  final DateTime? lastMessageAt;

  const ChatEntity({
    required this.id,
    required this.customerId,
    required this.customerName,
    this.lastMessage,
    this.lastMessageAt,
  });

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        lastMessage,
        lastMessageAt,
      ];
}
