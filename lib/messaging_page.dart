
import 'package:flutter/material.dart';
import 'package:agora_rtm/agora_rtm.dart';
import 'package:agora_app/agora_config.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({super.key});

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  AgoraRtmClient? _client;
  AgoraRtmChannel? _channel;

  @override
  void initState() {
    super.initState();
    _initAgoraRtm();
  }

  void _initAgoraRtm() async {
    _client = await AgoraRtmClient.createInstance(AgoraConfig.appId);
    _client?.onMessageReceived = (AgoraRtmMessage message, String peerId) {
      setState(() {
        _messages.add("${peerId}: ${message.text}");
      });
    };
    _client?.onConnectionStateChanged = (int state, int reason) {
      if (state == 5) {
        _client?.logout();
      }
    };

    await _client?.login(AgoraConfig.token, "user");
    _channel = await _client?.createChannel(AgoraConfig.channelName);
    await _channel?.join();

    _channel?.onMemberJoined = (AgoraRtmMember member) {
      setState(() {
        _messages.add("Member joined: ${member.userId}");
      });
    };
    _channel?.onMemberLeft = (AgoraRtmMember member) {
      setState(() {
        _messages.add("Member left: ${member.userId}");
      });
    };
    _channel?.onMessageReceived = (AgoraRtmMessage message, AgoraRtmMember member) {
      setState(() {
        _messages.add("${member.userId}: ${message.text}");
      });
    };
  }

  @override
  void dispose() {
    _channel?.leave();
    _client?.logout();
    _client?.release();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _channel?.sendMessage(AgoraRtmMessage.fromText(_controller.text));
      setState(() {
        _messages.add("Me: ${_controller.text}");
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Messaging'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
