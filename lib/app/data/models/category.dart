class Category {
  final int? id;
  final String namaKategori;

  Category({this.id, required this.namaKategori});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      namaKategori: json['nama_kategori'],
    );
  }
}
