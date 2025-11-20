
import 'package:agora_rtm/agora_rtm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talknearn/core/routing/app_router.dart';
import 'package:talknearn/core/theme/app_theme.dart';
import 'package:talknearn/features/chat/application/chat_bloc.dart';
import 'package:talknearn/features/chat/data/agora_chat_repository.dart';
import 'package:talknearn/features/chat/domain/chat_repository.dart';
import 'package:talknearn/features/theme/application/theme_bloc.dart';
import 'package:talknearn/features/theme/application/theme_state.dart';
import 'package:talknearn/features/wallet/application/wallet_bloc.dart';
import 'package:talknearn/features/wallet/data/mock_wallet_repository.dart';
import 'package:talknearn/features/wallet/domain/wallet_repository.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // TODO: Replace with your Agora App ID
  final client = await AgoraRtmClient.createInstance('<--Add your App Id here-->');
  runApp(MyApp(client: client));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.client});

  final AgoraRtmClient client;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (context) => AgoraChatRepository(client),
        ),
        RepositoryProvider<WalletRepository>(
          create: (context) => MockWalletRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider(
            create: (context) => ChatBloc(
              context.read<ChatRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => WalletBloc(
              walletRepository: context.read<WalletRepository>(),
            ),
          ),
        ],
        child: BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'TalknEarn',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              routerConfig: router,
              debugShowCheckedModeBanner: false,
            );
          },
        ),
      ),
    );
  }
}
