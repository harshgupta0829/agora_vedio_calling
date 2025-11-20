
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import './chat_event.dart';
import './chat_state.dart';
import '../domain/chat_message.dart';
import '../domain/chat_repository.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository _chatRepository;
  StreamSubscription? _chatSubscription;

  ChatBloc(this._chatRepository) : super(ChatLoading()) {
    on<LoadChat>(_onLoadChat);
    on<SendMessage>(_onSendMessage);
    on<MessageReceived>(_onMessageReceived);
    on<ShowTypingIndicator>(_onShowTypingIndicator);
  }

  void _onLoadChat(LoadChat event, Emitter<ChatState> emit) {
    emit(ChatLoading());
    _chatSubscription?.cancel();
    _chatSubscription = _chatRepository.getMessages(event.userId).listen(
          (messages) => add(MessageReceived(messages)),
        );
  }

  void _onSendMessage(SendMessage event, Emitter<ChatState> emit) {
    add(const ShowTypingIndicator(true));
    _chatRepository.sendMessage(event.userId, event.message);
  }

  void _onShowTypingIndicator(
      ShowTypingIndicator event, Emitter<ChatState> emit) {
    if (state is ChatLoaded) {
      final currentState = state as ChatLoaded;
      emit(currentState.copyWith(isTyping: event.isTyping));
    }
  }

  void _onMessageReceived(MessageReceived event, Emitter<ChatState> emit) {
    emit(ChatLoaded(event.messages, isTyping: false));
  }

  @override
  Future<void> close() {
    _chatSubscription?.cancel();
    return super.close();
  }
}

class MessageReceived extends ChatEvent {
  final List<ChatMessage> messages;

  const MessageReceived(this.messages);

  @override
  List<Object> get props => [messages];
}

class ShowTypingIndicator extends ChatEvent {
  final bool isTyping;

  const ShowTypingIndicator(this.isTyping);

  @override
  List<Object> get props => [isTyping];
}
