// import 'package:flutter/material.dart';
// import 'package:kitapp/services/books_services.dart';
// import '../models/book_model.dart';

// class BookRiverpod extends ChangeNotifier {
//   bool? isLoading;
//   List<Product> products = [];
//   Map<int, String> imageUrls = {}; // Kitap ID'lerini ve URL'lerini tutacak bir map

//   void getBookData(int categoryId) {
//     isLoading = true;
//     notifyListeners();

//     BookService().getBooks(categoryId).then((value) {
//       if (value != null) {
//         products = value.product!;
//         isLoading = false;
//         notifyListeners();
//         print("Kitap Listesi: $products");
//         getBookImages(); // Resim URL'lerini çek
//       } else {
//         isLoading = false;
//         notifyListeners();
//       }
//     }).catchError((error) {
//       isLoading = false;
//       print("Hata: $error");
//       notifyListeners();
//     });
//   }

//   void getBookImages() async {
//     for (var product in products) {
//       if (product.cover != null) {
//         try {
//           final imageUrl = await BookService().getImageUrl(product.cover!);
//           imageUrls[product.id!] = imageUrl;
//           print("Resim URL'si: $imageUrl");
//           notifyListeners(); // Resim URL'si güncellendikçe UI yenilenir
//         } catch (e) {
//           print("Resim URL'si alınamadı: $e");
//         }
//       }
//     }
//   }
// }