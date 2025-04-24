import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/models/category_model.dart';
import 'package:kitapp/riverpod/login_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/riverpod/register_riverpod.dart';
import 'package:kitapp/services/book_cache_service.dart';
import 'package:kitapp/services/books_services.dart';
import 'package:kitapp/services/category_service.dart';
import 'package:kitapp/services/search_service.dart';

final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
final registerProvider = ChangeNotifierProvider((_) => RegisterRiverpod());
final rememberMeProvider = StateProvider<bool>((ref) => false);
final categoryProvider = FutureProvider<List<Category>>((ref) async {
  return fetchCategories();
});

final selectedCategoryProvider = StateProvider<int>((ref) => 0);

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

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProvider = StateNotifierProvider<SearchNotifier, List<Book>>((ref) => SearchNotifier());