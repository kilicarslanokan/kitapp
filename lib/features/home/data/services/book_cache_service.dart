import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/features/home/data/models/book_model.dart';

class BookCacheNotifier extends StateNotifier<Map<int, List<Book>>> {
  BookCacheNotifier() : super({});

  bool hasCategory(int categoryId) {
    return state.containsKey(categoryId);
  }

  List<Book> getBooks(int categoryId) {
    return state[categoryId] ?? [];
  }

  void setBooks(int categoryId, List<Book> books) {
    state = {...state, categoryId: books};
  }
}
