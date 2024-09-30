import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/models/supplier.dart';
import '../helper/helper.dart';

class SupplierRepository {
  Future<List<Supplier>> fetchSuppliers() async {
    final response = await http.get(Uri.parse('$apiUrl/suppliers'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse
          .map((supplier) => Supplier.fromJson(supplier))
          .toList();
    } else {
      throw Exception('Failed to load suppliers');
    }
  }

  Future<void> createSupplier(Supplier supplier) async {
    final response = await http.post(
      Uri.parse('$apiUrl/suppliers'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_supplier': supplier.namaSupplier,
        'kontak_supplier': supplier.kontakSupplier,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create supplier');
    }
  }
}
