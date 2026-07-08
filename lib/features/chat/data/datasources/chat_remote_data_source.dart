import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/chat_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ChatModel>> getChats();
  Future<List<ChatModel>> searchChats(String query);
  Stream<List<MessageModel>> getMessages(String chatId);
  Future<void> sendMessage({
    required String chatId,
    required String customerName,
    required MessageModel message,
  });
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  });
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseFirestore firestore;

  static const String _collection = 'chats';

  ChatRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<ChatModel>> getChats() async {
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('lastMessageAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => ChatModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<List<ChatModel>> searchChats(String query) async {
    final snapshot = await firestore
        .collection(_collection)
        .orderBy('lastMessageAt', descending: true)
        .get();
    final lowerQuery = query.toLowerCase();
    return snapshot.docs
        .map((doc) => ChatModel.fromMap(doc.data(), doc.id))
        .where((chat) =>
            chat.customerName.toLowerCase().contains(lowerQuery) ||
            (chat.lastMessage?.toLowerCase().contains(lowerQuery) ?? false))
        .toList();
  }

  @override
  Stream<List<MessageModel>> getMessages(String chatId) {
    return firestore
        .collection(_collection)
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  @override
  Future<void> sendMessage({
    required String chatId,
    required String customerName,
    required MessageModel message,
  }) async {
    final chatRef = firestore.collection(_collection).doc(chatId);
    await chatRef.set({
      'customerId': chatId,
      'customerName': customerName,
      'lastMessage': message.text,
      'lastMessageAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await chatRef.collection('messages').add(message.toFirestore());
  }

  @override
  Future<void> deleteMessage({
    required String chatId,
    required String messageId,
  }) async {
    await firestore
        .collection(_collection)
        .doc(chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }
}
