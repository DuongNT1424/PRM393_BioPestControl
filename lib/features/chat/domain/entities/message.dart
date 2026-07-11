import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  final String? id;
  final String senderId;
  final String senderName;
  final String senderRole;
  final String text;
  final DateTime? createdAt;

  const MessageEntity({
    this.id,
    required this.senderId,
    required this.senderName,
    required this.senderRole,
    required this.text,
    this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        senderId,
        senderName,
        senderRole,
        text,
        createdAt,
      ];
}
