
import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String sender;
  final String? avatarUrl;

  const ChatMessage({
    required this.text,
    required this.isMe,
    required this.timestamp,
    required this.sender,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [text, isMe, timestamp, sender, avatarUrl];
}
