import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/features/category/data/models/category_model.dart';
import 'package:kitapp/features/category/data/services/category_service.dart';

final categoryProvider = FutureProvider<List<Category>>((ref) async {
  return fetchCategories();
});

final selectedCategoryProvider = StateProvider<int>((ref) => 0);