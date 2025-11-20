
import 'package:go_router/go_router.dart';
import 'package:talknearn/features/agora/voice_call_screen.dart';
import 'package:talknearn/features/home/presentation/screens/home_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/voice-call',
      builder: (context, state) => const VoiceCallScreen(),
    ),
  ],
);
