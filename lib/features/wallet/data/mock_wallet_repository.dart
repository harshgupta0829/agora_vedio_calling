
import 'package:talknearn/features/wallet/domain/transaction.dart';
import 'package:talknearn/features/wallet/domain/wallet_repository.dart';

class MockWalletRepository implements WalletRepository {
  @override
  Future<double> getBalance(String userId) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return a mock balance
    return 1234.56;
  }

  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 1));

    // Return a mock list of transactions
    return [
      Transaction(
        description: 'Received from John Doe',
        amount: 50.00,
        date: DateTime.now().subtract(const Duration(days: 1)),
        isCredit: true,
      ),
      Transaction(
        description: 'Sent to Jane Smith',
        amount: 25.50,
        date: DateTime.now().subtract(const Duration(days: 2)),
        isCredit: false,
      ),
      Transaction(
        description: 'Earned from chat',
        amount: 10.00,
        date: DateTime.now().subtract(const Duration(days: 3)),
        isCredit: true,
      ),
      Transaction(
        description: 'Withdrawal',
        amount: 100.00,
        date: DateTime.now().subtract(const Duration(days: 4)),
        isCredit: false,
      ),
      Transaction(
        description: 'Received from Alice',
        amount: 15.00,
        date: DateTime.now().subtract(const Duration(days: 5)),
        isCredit: true,
      ),
    ];
  }
}
