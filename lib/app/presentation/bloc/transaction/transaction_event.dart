import '../../../core/models/transaction.dart';

abstract class TransactionEvent {}

class FetchTransactions extends TransactionEvent {}

class CreateTransaction extends TransactionEvent {
  final Transaction transaction;

  CreateTransaction(this.transaction);
}

class UpdateTransaction extends TransactionEvent {
  final Transaction transaction;

  UpdateTransaction(this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final int id;

  DeleteTransaction(this.id);
}
