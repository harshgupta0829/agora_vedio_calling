
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talknearn/features/wallet/application/wallet_bloc.dart';
import 'package:talknearn/features/wallet/application/wallet_event.dart';
import 'package:talknearn/features/wallet/application/wallet_state.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(const GetWallet('user123'));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallet'),
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
      ),
      backgroundColor: theme.colorScheme.surface,
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is WalletLoaded) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Balance: \$${state.balance.toStringAsFixed(2)}',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Transactions',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = state.transactions[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              transaction.isCredit
                                  ? Icons.arrow_downward
                                  : Icons.arrow_upward,
                              color: transaction.isCredit ? Colors.green : Colors.red,
                            ),
                            title: Text(transaction.description),
                            trailing: Text(
                              '\$${transaction.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                color: transaction.isCredit ? Colors.green : Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              transaction.date.toString(),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }
          if (state is WalletError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          }
          return const Center(
            child: Text('Welcome to your wallet!'),
          );
        },
      ),
    );
  }
}
