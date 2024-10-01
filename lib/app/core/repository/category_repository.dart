import 'dart:convert';
import 'package:http/http.dart' as http;
import '../helper/helper.dart';
import '../models/category.dart';

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

  Future<List<Category>> searchCategories(String query) async {
    final response =
        await http.get(Uri.parse('$apiUrl/categories?search=$query'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body)["data"];
      return jsonResponse
          .map((category) => Category.fromJson(category))
          .toList();
    } else {
      throw Exception('Failed to search categories');
    }
  }

  Future<void> deleteCategory(int id) async {
    final response = await http.delete(Uri.parse('$apiUrl/categories/$id'));

    if (response.statusCode == 400) {
      final errorResponse = json.decode(response.body);
      throw Exception(errorResponse["error"]);
    } else if (response.statusCode != 200) {
      throw Exception(response.body);
    }
  }
}
