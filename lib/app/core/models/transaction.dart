import 'dart:convert';

class Transaction {
  final int? id; // ID transaksi, bisa null jika belum ada di database
  final int itemId; // ID barang yang berhubungan dengan transaksi
  final int quantity; // Jumlah barang dalam transaksi
  final double totalPrice; // Harga total transaksi
  final DateTime transactionDate; // Tanggal transaksi
  final String
      transactionType; // Jenis transaksi ('in' untuk masuk, 'out' untuk keluar)

  // Constructor untuk model Transaction
  Transaction({
    this.id, // ID opsional
    required this.itemId,
    required this.quantity,
    required this.totalPrice,
    DateTime? transactionDate,
    required this.transactionType,
  }) : transactionDate = transactionDate ??
            DateTime.now(); // Jika tidak ada tanggal, gunakan waktu sekarang

  // Mengonversi model ke dalam Map untuk penyimpanan
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'item_id': itemId,
      'quantity': quantity,
      'total_price': totalPrice,
      'transaction_date': transactionDate.toIso8601String(),
      'transaction_type': transactionType,
    };
  }

  // Membuat model dari Map (misalnya dari respons API)
  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as int : null,
      // Mengambil ID dari map
      itemId: map['item_id'] as int,
      // Mengambil item_id dari map
      quantity: map['quantity'] as int,
      // Mengambil quantity dari map
      totalPrice:
          (map['total_price'] is int) // Pastikan total_price adalah double
              ? (map['total_price'] as int).toDouble()
              : map['total_price'] as double,
      transactionDate: DateTime.parse(map['transaction_date']),
      // Mengambil dan memparsing tanggal
      transactionType: map['transaction_type']
          as String, // Mengambil transaction_type dari map
    );
  }

  // Mengonversi model ke JSON untuk pengiriman
  String toJson() => json.encode(toMap());

  // Membuat model dari JSON (misalnya dari respons API)
  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
