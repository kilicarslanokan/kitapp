import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:kitapp/models/book_model.dart';

class SearchNotifier extends StateNotifier<List<Book>> {
  SearchNotifier() : super([]);
  final Map<int, Book> _cache = {};

  Future<void> searchBooks(String query) async {
    List<Future<Book>> futures = [];
    for (int i = 3; i <= 17; i++) {
      if (_cache.containsKey(i)) {
        futures.add(Future.value(_cache[i]));
      } else {
        futures.add(_fetchBook(i));
      }
    }
    List<Book> books = await Future.wait(futures);
    state = books.where((book) =>
      book.name.toLowerCase().contains(query.toLowerCase()) ||
      book.author.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

  Future<Book> _fetchBook(int id) async {
    final response = await http.get(Uri.parse('https://assign-api.piton.com.tr/api/rest/product/$id'));
    final book = Book.fromJson(json.decode(response.body)['product_by_pk']);
    book.cover = await fetchCoverImageUrl(book.cover); // arama çubuğuna resimleri çekebilmek için
    _cache[id] = book;
    return book;
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
}