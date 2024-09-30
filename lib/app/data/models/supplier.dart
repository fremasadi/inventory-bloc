class Supplier {
  final int id;
  final String namaSupplier;
  final String kontakSupplier;

  Supplier({
    required this.id,
    required this.namaSupplier,
    required this.kontakSupplier,
  });

  factory Supplier.fromJson(Map<String, dynamic> json) {
    return Supplier(
      id: json['id'],
      namaSupplier: json['nama_supplier'],
      kontakSupplier: json['kontak_supplier'],
    );
  }
}
