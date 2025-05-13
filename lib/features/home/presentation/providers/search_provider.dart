import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/features/home/data/models/book_model.dart';
import 'package:kitapp/features/home/data/services/search_service.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchProvider = StateNotifierProvider<SearchNotifier, List<Book>>((ref) => SearchNotifier());