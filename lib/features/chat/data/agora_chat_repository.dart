
import 'dart:async';

import 'package:agora_rtm/agora_rtm.dart';
import 'package:flutter/foundation.dart';
import 'package:talknearn/features/chat/domain/chat_message.dart';
import 'package:talknearn/features/chat/domain/chat_repository.dart';

class AgoraChatRepository implements ChatRepository {
  final AgoraRtmClient _client;
  AgoraRtmChannel? _channel;
  final _messagesController = StreamController<List<ChatMessage>>.broadcast();
  final List<ChatMessage> _messages = [];
  String? _userId;

  AgoraChatRepository(this._client) {
    _client.onMessageReceived = (message, peerId) {
      _messages.add(ChatMessage(
        sender: peerId,
        text: message.text,
        timestamp: DateTime.now(),
        isMe: _userId == peerId,
      ));
      _messagesController.add(_messages);
    };
  }

  Future<void> login(String userId) async {
    _userId = userId;
    try {
      await _client.login(null, userId);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to login to RTM: $e');
      }
    }
  }

  Future<void> joinChannel(String channelId) async {
    try {
      _channel = await _client.createChannel(channelId);
      await _channel?.join();
    } catch (e) {
      if (kDebugMode) {
        print('Failed to join channel: $e');
      }
    }
  }

  @override
  Future<void> sendMessage(String userId, ChatMessage message) async {
    try {
      final rtmMessage = RtmMessage.fromText(message.text);
      await _channel?.sendMessage2(rtmMessage);
      _messages.add(message);
      _messagesController.add(_messages);
    } catch (e) {
      if (kDebugMode) {
        print('Failed to send message: $e');
      }
    }
  }

  @override
  Stream<List<ChatMessage>> getMessages(String userId) {
    return _messagesController.stream;
  }

  void onMessageReceived(void Function(RtmMessage, RtmChannelMember) callback) {
    _channel?.onMessageReceived = callback;
  }

  Future<void> logout() async {
    try {
      await _channel?.leave();
      await _client.logout();
      _userId = null;
    } catch (e) {
      if (kDebugMode) {
        print('Failed to logout: $e');
      }
    }
  }
}
