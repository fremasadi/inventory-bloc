class Transaction {
  final int id;
  final int idBarang;
  final int jumlah;
  final String tipeTransaksi;
  final String tanggalTransaksi;
  final double hargaSatuan;

  Transaction({
    required this.id,
    required this.idBarang,
    required this.jumlah,
    required this.tipeTransaksi,
    required this.tanggalTransaksi,
    required this.hargaSatuan,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      idBarang: json['id_barang'],
      jumlah: json['jumlah'],
      tipeTransaksi: json['tipe_transaksi'],
      tanggalTransaksi: json['tanggal_transaksi'],
      hargaSatuan: json['harga_satuan'].toDouble(),
    );
  }
}
