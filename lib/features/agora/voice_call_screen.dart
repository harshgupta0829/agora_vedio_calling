
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class VoiceCallScreen extends StatefulWidget {
  const VoiceCallScreen({super.key});

  @override
  State<VoiceCallScreen> createState() => _VoiceCallScreenState();
}

class _VoiceCallScreenState extends State<VoiceCallScreen> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: 'e5f29915569448139e8020a531405b8a',
      channelName: 'test',
    ),
    enabledPermission: [
      Permission.microphone,
    ],
  );

  @override
  void initState() {
    super.initState();
    client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            AgoraVideoViewer(
              client: client,
              layoutType: Layout.floating,
              showNumberOfUsers: true,
            ),
            AgoraVideoButtons(
              client: client,
              enabledButtons: const [
                BuiltInButtons.toggleMic,
                BuiltInButtons.callEnd,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
