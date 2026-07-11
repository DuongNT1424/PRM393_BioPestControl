import 'package:cloud_firestore/cloud_firestore.dart';
import '../../domain/entities/chat.dart';

class ChatModel extends ChatEntity {
  const ChatModel({
    required super.id,
    required super.customerId,
    required super.customerName,
    super.lastMessage,
    super.lastMessageAt,
  });

  factory ChatModel.fromMap(Map<String, dynamic> data, String id) {
    return ChatModel(
      id: id,
      customerId: data['customerId'] ?? id,
      customerName: data['customerName'] ?? 'Khách hàng',
      lastMessage: data['lastMessage'],
      lastMessageAt: (data['lastMessageAt'] as Timestamp?)?.toDate(),
    );
  }
}
