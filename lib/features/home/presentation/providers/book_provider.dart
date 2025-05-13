import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/features/home/data/models/book_model.dart';
import 'package:kitapp/features/home/data/services/book_cache_service.dart';
import 'package:kitapp/features/home/data/services/books_services.dart';

final bookCacheProvider = StateNotifierProvider<BookCacheNotifier, Map<int, List<Book>>>((ref) => BookCacheNotifier());

final bookProvider = FutureProvider.family<List<Book>, int>((ref, categoryId) async {
  final bookCache = ref.read(bookCacheProvider.notifier);
  if (bookCache.hasCategory(categoryId)) {
    return bookCache.getBooks(categoryId);
  } else {
    final books = await fetchBooks(categoryId);
    bookCache.setBooks(categoryId, books);
    return books;
  }
});