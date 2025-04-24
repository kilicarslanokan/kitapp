// import 'package:flutter/material.dart';
// import '../models/category_model.dart';
// import '../services/category_service.dart';

// class CategoryRiverpod extends ChangeNotifier {
//   bool isLoading = false;
//   List<Category> categories = [];

//   void getCategories() async {
//     //if (isLoading) return;
//     isLoading = true;
//     //notifyListeners();

//     try {
//       categories = await CategoryService().getCategories();
//       print("Kategori Listesi: $categories");
//     } catch (e) {
//       print("Kategori çekme hatası: $e");
//     } finally {
//       isLoading = false;
//       //notifyListeners();
//     }
//   }
// }