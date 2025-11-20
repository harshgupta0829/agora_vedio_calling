
import 'package:equatable/equatable.dart';

class Transaction extends Equatable {
  final String description;
  final double amount;
  final DateTime date;
  final bool isCredit;

  const Transaction({
    required this.description,
    required this.amount,
    required this.date,
    required this.isCredit,
  });

  @override
  List<Object?> get props => [description, amount, date, isCredit];
}
