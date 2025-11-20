
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talknearn/features/chat/application/chat_bloc.dart';
import 'package:talknearn/features/chat/application/chat_event.dart';
import 'package:talknearn/features/chat/application/chat_state.dart';
import 'package:talknearn/features/chat/domain/chat_message.dart';
import 'package:talknearn/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:talknearn/features/chat/presentation/widgets/chat_input.dart';
import 'package:talknearn/features/chat/presentation/widgets/typing_indicator.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    // Use a static user ID for now
    context.read<ChatBloc>().add(const LoadChat('user123'));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        actions: [
          IconButton(
            onPressed: () {
              context.go('/voice-call');
            },
            icon: const Icon(Icons.call),
          ),
        ],
      ),
      backgroundColor: theme.colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is ChatLoaded) {
                  return ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.all(8.0),
                    itemCount: state.messages.length + (state.isTyping ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (state.isTyping && index == 0) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          child: TypingIndicator(),
                        );
                      }
                      final messageIndex = state.isTyping ? index - 1 : index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: ChatBubble(message: state.messages[messageIndex]),
                      );
                    },
                  );
                }
                if (state is ChatError) {
                  return Center(
                    child: Text('Error: ${state.message}'),
                  );
                }
                return const Center(
                  child: Text('Welcome to the chat!'),
                );
              },
            ),
          ),
          ChatInput(
            onSendMessage: (message) {
              final chatMessage = ChatMessage(
                text: message,
                sender: 'user123',
                isMe: true,
                timestamp: DateTime.now(),
              );
              context.read<ChatBloc>().add(SendMessage('user123', chatMessage));
            },
          ),
        ],
      ),
    );
  }
}
