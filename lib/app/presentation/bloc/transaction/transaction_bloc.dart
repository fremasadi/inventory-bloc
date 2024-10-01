import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/repository/transaction_repository.dart';
import 'transaction_event.dart';
import 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final TransactionRepository transactionRepository;

  TransactionBloc(this.transactionRepository) : super(TransactionInitial()) {
    on<FetchTransactions>((event, emit) async {
      emit(TransactionLoading());
      try {
        final transactions = await transactionRepository.fetchTransactions();
        emit(TransactionLoaded(transactions));
      } catch (e) {
        emit(TransactionError('Failed to fetch transactions: ${e.toString()}'));
      }
    });

    on<CreateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionRepository.createTransaction(event.transaction);
        emit(TransactionLoading()); // Optional: emit loading again if you want
        add(FetchTransactions()); // Fetch transactions after creating a new one
      } catch (e) {
        emit(TransactionError('Failed to create transaction: ${e.toString()}'));
      }
    });

    on<UpdateTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionRepository.updateTransaction(event.transaction);
        emit(TransactionLoading()); // Optional: emit loading again if you want
        add(FetchTransactions()); // Fetch transactions after updating
      } catch (e) {
        emit(TransactionError('Failed to update transaction: ${e.toString()}'));
      }
    });

    on<DeleteTransaction>((event, emit) async {
      emit(TransactionLoading());
      try {
        await transactionRepository.deleteTransaction(event.id);
        emit(TransactionLoading()); // Optional: emit loading again if you want
        add(FetchTransactions()); // Fetch transactions after deletion
      } catch (e) {
        emit(TransactionError('Failed to delete transaction: ${e.toString()}'));
      }
    });
  }
}
