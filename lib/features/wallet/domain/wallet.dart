
import 'package:talknearn/features/wallet/domain/transaction.dart';

class Wallet {
  final String id;
  final String userId;
  final double balance;
  final List<Transaction> transactions;

  Wallet({
    required this.id,
    required this.userId,
    required this.balance,
    required this.transactions,
  });
}
