import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:talknearn/features/chat/domain/chat_message.dart';
import 'package:talknearn/features/chat/domain/chat_repository.dart';

class FirebaseChatRepository implements ChatRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ChatMessage>> getMessages(String userId) {
    return _firestore
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return ChatMessage(
          text: data['text'] as String,
          sender: data['sender'] as String,
          isMe: data['sender'] == userId,
          timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          avatarUrl: data['avatarUrl'] as String?,
        );
      }).toList();
    });
  }

  @override
  Future<void> sendMessage(String userId, ChatMessage message) {
    return _firestore
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .add({
      'text': message.text,
      'sender': message.sender,
      'timestamp': FieldValue.serverTimestamp(),
      'avatarUrl': message.avatarUrl,
    });
  }
}
