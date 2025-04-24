import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitapp/models/category_model.dart';

Future<List<Category>> fetchCategories() async {
  final response = await http.get(
    Uri.parse('https://assign-api.piton.com.tr/api/rest/categories'),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['category'] as List;
    return data.map((json) => Category.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load categories');
  }
}
