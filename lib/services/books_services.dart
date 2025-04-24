import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kitapp/models/book_model.dart';

Future<List<Book>> fetchBooks(int categoryId) async {
  if (categoryId == 0) {
    List<Book> allBooks = [];
    for (int i = 1; i <= 4; i++) {
      final books = await _fetchBooksByCategory(i);
      allBooks.addAll(books);
    }
    return allBooks;
  } else {
    return await _fetchBooksByCategory(categoryId);
  }
}

Future<List<Book>> _fetchBooksByCategory(int categoryId) async {
  final response = await http.get(
    Uri.parse('https://assign-api.piton.com.tr/api/rest/products/$categoryId'),
    headers: {'x-hasura-user-id': '422'},
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body)['product'] as List;
    List<Book> books = data.map((json) => Book.fromJson(json)).toList();

    for (var book in books) {
      book.cover = await fetchCoverImageUrl(book.cover);
    }

    return books;
  } else {
    throw Exception('Failed to load books');
  }
}

Future<String> fetchCoverImageUrl(String fileName) async {
  final response = await http.post(
    Uri.parse('https://assign-api.piton.com.tr/api/rest/cover_image'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({'fileName': fileName}),
  );

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['action_product_image']['url'];
  } else {
    throw Exception('Failed to load cover image');
  }
}