
import 'package:flutter/material.dart';
import 'package:talknearn/features/chat/domain/chat_message.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isMe = message.isMe;
    final theme = Theme.of(context);

    final avatar = CircleAvatar(
      radius: 20,
      backgroundImage: (message.avatarUrl != null && message.avatarUrl!.isNotEmpty)
          ? NetworkImage(message.avatarUrl!)
          : null,
      child: (message.avatarUrl == null || message.avatarUrl!.isEmpty)
          ? const Icon(Icons.person)
          : null,
    );

    final bubbleContent = Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: Radius.circular(isMe ? 20 : 0),
            bottomRight: Radius.circular(isMe ? 0 : 20),
          ),
        ),
        color: isMe
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                isMe ? 'You' : message.sender,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isMe
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                message.text,
                style: TextStyle(
                  color: isMe
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onSecondaryContainer,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                DateFormat.jm().format(message.timestamp),
                style: TextStyle(
                  fontSize: 10,
                  color: (isMe
                          ? theme.colorScheme.onPrimaryContainer
                          : theme.colorScheme.onSecondaryContainer)
                      .withAlpha(178),
                ),
              ),
            ],
          ),
        ),
      );

    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        if (!isMe)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: avatar,
          ),
        Flexible(
          child: bubbleContent,
        ),
        if (isMe)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: avatar,
          ),
      ],
    );
  }
}
