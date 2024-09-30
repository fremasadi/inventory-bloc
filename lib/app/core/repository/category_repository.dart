import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/models/category.dart';
import '../helper/helper.dart';

class CategoryRepository {
  Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$apiUrl/categories'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<void> createCategory(Category category) async {
    final response = await http.post(
      Uri.parse('$apiUrl/categories'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'nama_kategori': category.namaKategori}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else {
      throw Exception('Failed to create category: ${response.body}');
    }
  }

  Future<void> updateCategory(Category category) async {
    final response = await http.put(
      Uri.parse('$apiUrl/categories/${category.id}'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"nama_kategori": category.namaKategori}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }
}
