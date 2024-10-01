import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/helper.dart';
import '../models/item.dart';

class ItemRepository {
  Future<List<Item>> fetchItems() async {
    final response = await http.get(Uri.parse('$apiUrl/items'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load items');
    }
  }

  Future<void> createItem(Item item) async {
    final response = await http.post(
      Uri.parse('$apiUrl/items'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_barang': item.namaBarang,
        'deskripsi': item.deskripsi,
        'stok': item.stok,
        'harga': item.harga,
        'kategori_id': item.kategoriId,
        'supplier_id': item.supplierId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to create item');
    }
  }

  Future<void> updateItem(Item item) async {
    final response = await http.put(
      Uri.parse('$apiUrl/items/${item.id}'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_barang': item.namaBarang,
        'deskripsi': item.deskripsi,
        'stok': item.stok,
        'harga': item.harga,
        'kategori_id': item.kategoriId,
        'supplier_id': item.supplierId,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update item');
    }
  }

  Future<void> deleteItem(int id) async {
    final response = await http.delete(
      Uri.parse('$apiUrl/items/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8'
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete item');
    }
  }

  Future<List<Item>> searchItems(String query) async {
    final response = await http.get(Uri.parse('$apiUrl/items?search=$query'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse.map((item) => Item.fromJson(item)).toList();
    } else {
      throw Exception('Failed to search items');
    }
  }
}
