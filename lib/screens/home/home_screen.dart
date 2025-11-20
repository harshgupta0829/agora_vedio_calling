
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:talknearn/features/theme/application/theme_bloc.dart';
import 'package:talknearn/features/theme/application/theme_event.dart';
import 'package:talknearn/features/theme/application/theme_state.dart';
import 'package:talknearn/services/razorpay_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late RazorpayService _razorpayService;

  @override
  void initState() {
    super.initState();
    _razorpayService = RazorpayService();
  }

  @override
  void dispose() {
    _razorpayService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('TalknEarn'),
            actions: [
              IconButton(
                icon: Icon(state.themeMode == ThemeMode.dark
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: () => context.read<ThemeBloc>().add(ThemeToggled()),
                tooltip: 'Toggle Theme',
              ),
              IconButton(
                icon: const Icon(Icons.auto_mode),
                onPressed: () =>
                    context.read<ThemeBloc>().add(SystemThemeSet()),
                tooltip: 'Set System Theme',
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Welcome to TalknEarn!',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                const SizedBox(height: 20),
                Text(
                  'The app is under construction.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => context.go('/chat'),
                  child: const Text('Messages'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/wallet'),
                  child: const Text('Wallet'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/video_call'),
                  child: const Text('Video Call'),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _razorpayService.openCheckout(
                      100,
                      'TalknEarn Credits',
                      'Buy credits for TalknEarn',
                      '1234567890',
                      'test@example.com',
                    );
                  },
                  child: const Text('Buy Credits'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
