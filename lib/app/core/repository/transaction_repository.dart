import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/helper.dart';
import '../models/transaction.dart';

class TransactionRepository {
  Future<List<Transaction>> fetchTransactions() async {
    final response = await http.get(Uri.parse('$apiUrl/transactions'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse.map((item) => Transaction.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  // Create a new transaction
  Future<void> createTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$apiUrl/transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: transaction.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create transaction');
    }
  }

  // Update an existing transaction
  Future<void> updateTransaction(Transaction transaction) async {
    final response = await http.put(
      Uri.parse('$apiUrl/transactions/${transaction.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: transaction.toJson(),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction');
    }
  }

  // Delete a transaction
  Future<void> deleteTransaction(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/transactions/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction');
    }
  }
}
