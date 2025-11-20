
import 'package:talknearn/features/wallet/domain/transaction.dart';

abstract class WalletRepository {
  Future<double> getBalance(String userId);
  Future<List<Transaction>> getTransactions(String userId);
}
