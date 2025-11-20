
import 'package:equatable/equatable.dart';
import 'package:talknearn/features/chat/domain/chat_message.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class LoadChat extends ChatEvent {
  final String userId;

  const LoadChat(this.userId);

  @override
  List<Object> get props => [userId];
}

class SendMessage extends ChatEvent {
  final String userId;
  final ChatMessage message;

  const SendMessage(this.userId, this.message);

  @override
  List<Object> get props => [userId, message];
}
