import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/helper.dart';
import '../models/transaction.dart';

class TransactionRepository {
  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse('$apiUrl/transactions'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body)['data'];
      return jsonResponse
          .map((transaction) => Transaction.fromJson(transaction))
          .toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<void> createTransaction(Transaction transaction) async {
    final response = await http.post(
      Uri.parse('$apiUrl/transactions'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id_barang': transaction.idBarang,
        'jumlah': transaction.jumlah,
        'tipe_transaksi': transaction.tipeTransaksi,
        'harga_satuan': transaction.hargaSatuan,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create transaction');
    }
  }
}
