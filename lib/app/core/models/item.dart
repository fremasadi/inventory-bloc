class Item {
  final int? id;
  final String namaBarang;
  final String deskripsi;
  final int stok;
  final double harga;
  final int kategoriId;
  final int supplierId;

  Item({
    this.id,
    required this.namaBarang,
    required this.deskripsi,
    required this.stok,
    required this.harga,
    required this.kategoriId,
    required this.supplierId,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      namaBarang: json['nama_barang'],
      deskripsi: json['deskripsi'],
      stok: json['stok'],
      harga: json['harga'].toDouble(),
      kategoriId: json['kategori_id'],
      supplierId: json['supplier_id'],
    );
  }
}
