
import './chat_message.dart';

abstract class ChatRepository {
  Stream<List<ChatMessage>> getMessages(String userId);
  Future<void> sendMessage(String userId, ChatMessage message);
}
