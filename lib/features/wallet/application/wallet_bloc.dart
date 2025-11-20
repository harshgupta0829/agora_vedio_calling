
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talknearn/features/wallet/application/wallet_event.dart';
import 'package:talknearn/features/wallet/application/wallet_state.dart';
import 'package:talknearn/features/wallet/domain/wallet_repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository walletRepository;

  WalletBloc({required this.walletRepository}) : super(WalletInitial()) {
    on<GetWallet>((event, emit) async {
      emit(WalletLoading());
      try {
        final balance = await walletRepository.getBalance(event.userId);
        final transactions = await walletRepository.getTransactions(event.userId);
        emit(WalletLoaded(balance: balance, transactions: transactions));
      } catch (e) {
        emit(WalletError(e.toString()));
      }
    });
  }
}
