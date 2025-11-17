
import 'package:flutter/material.dart';
import 'package:agora_app/video_call_page.dart';
import 'package:agora_app/voice_call_page.dart';
import 'package:agora_app/messaging_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VideoCallPage()),
                );
              },
              child: const Text('Video Call'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const VoiceCallPage()),
                );
              },
              child: const Text('Voice Call'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MessagingPage()),
                );
              },
              child: const Text('Messaging'),
            ),
          ],
        ),
      ),
    );
  }
}
