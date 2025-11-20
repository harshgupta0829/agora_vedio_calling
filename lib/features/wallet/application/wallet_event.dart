
import 'package:equatable/equatable.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetWallet extends WalletEvent {
  final String userId;

  const GetWallet(this.userId);

  @override
  List<Object> get props => [userId];
}
