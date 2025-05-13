import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/features/category/presentation/providers/category_provider.dart';
import 'package:kitapp/features/home/presentation/providers/search_provider.dart';
import 'package:kitapp/features/detail/presentation/pages/book_details_screen.dart';
import 'package:kitapp/features/category/presentation/pages/category_screen.dart';
import 'package:kitapp/widgets/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:kitapp/widgets/search_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Dil desteği için kullanıyoruz
    var d = AppLocalizations.of(context)!;

    // Tüm Kitapları başlangıçta bir kez yüklemek için kullanıyoruz
    Future.microtask(() {
      if (ref.read(searchQueryProvider) == "") {
        ref.read(searchProvider.notifier).searchBooks("");
      }
    });

    final categoryAsyncValue = ref.watch(categoryProvider);
    final selectedCategoryId = ref.watch(selectedCategoryProvider) ?? 0;
    final searchQuery = ref.watch(searchQueryProvider);
    final books = ref.watch(searchProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/Logo.png', height: 35.h),
            Text(d.catalog, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0.w),
            child: Column(
              children: [
                categoryAsyncValue.when(
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('Hata: $err')),
                  data: (categories) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              ref.read(selectedCategoryProvider.notifier).state = 0;
                            },
                            // Böyle de kullanılabilir:
                            // onPressed: () => ref.read(selectedCategoryProvider.notifier).state = 0,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              foregroundColor: selectedCategoryId == 0 ? Colors.white : Colors.black38,
                              backgroundColor: selectedCategoryId == 0 ? Colors.deepPurple : cardRenk,
                            ),
                            child: Text(d.all,
                                style: TextStyle(fontSize: 14.sp)),
                          ),
                          SizedBox(width: 8.w),
                          ...categories.map((category) {
                            final isSelected = selectedCategoryId == category.id;
                            return Row(
                              children: [
                                ElevatedButton(
                                  onPressed: () => // Kategoriye tıklandığında seçili kategoriyi güncelliyoruz
                                    ref.read(selectedCategoryProvider.notifier).state = category.id,
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0),
                                    ),
                                    foregroundColor: isSelected ? Colors.white : Colors.black38,
                                    backgroundColor: isSelected ? Colors.deepPurple : cardRenk,
                                  ),
                                  child: Text(category.name,
                                      style: TextStyle(fontSize: 14.sp)),
                                ),
                                SizedBox(width: 8.w),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                SearchTextField(
                  hintText: d.search,
                  onChanged: (value) {
                  ref.read(searchQueryProvider.notifier).state = value;
                  ref.read(searchProvider.notifier).searchBooks(value);
                }),
                SizedBox(height: 8.h),
                Expanded(
                  child: categoryAsyncValue.when(
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Hata: $err')),
                    data: (categories) {
                      final filteredBooks = searchQuery.isNotEmpty
                          ? books
                          : selectedCategoryId == 0
                              ? books
                              : books.where((book) => book.categoryId == selectedCategoryId).toList();

                      if (filteredBooks.isEmpty) {
                        return Center(child: Text(d.searchResult));
                      }

                      return ListView.builder(
                        itemCount: categories.length,
                        itemBuilder: (context, categoryIndex) {
                          final category = categories[categoryIndex];
                          final categoryBooks = filteredBooks
                              .where((book) => book.categoryId == category.id)
                              .toList();

                          if (categoryBooks.isEmpty) {
                            return SizedBox.shrink();
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 6.0.h, horizontal: 8.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category.name,
                                      style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CategoryScreen(
                                              category: category,
                                              books: categoryBooks,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        d.viewAll,
                                        style: TextStyle(color: butonRenk, fontSize: 14.sp),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 130.h, // Kartların yüksekliği
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: categoryBooks.length,
                                  itemBuilder: (context, bookIndex) {
                                    final book = categoryBooks[bookIndex];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => BookDetailsScreen(book: book),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        width: 220.w, // Kartın genişliği
                                        margin: EdgeInsets.only(right: 12.w),
                                        child: Card(
                                          elevation: 3,
                                          child: Padding(
                                            padding: EdgeInsets.all(6.0.w),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  book.cover,
                                                  width: 80.w,
                                                  height: 150.h,
                                                  fit: BoxFit.cover,
                                                ),
                                                SizedBox(width: 8.w),
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          book.name,
                                                          style: TextStyle(
                                                            color: textRenk,
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14.sp,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 2.h),
                                                        Text(
                                                          book.author,
                                                          style: TextStyle(fontSize: 12.sp, color: textRenk2),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${book.price} ' + d.moneyType,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: anaRenk,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SizedBox(height: 12.h),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
// Arama sonuçlarını göstermek için bir açılır liste
          if (searchQuery.isNotEmpty)
            Positioned(
              top: 130,
              left: 8,
              right: 8,
              child: Material(
                elevation: 4.0,
                borderRadius: BorderRadius.circular(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    return ListTile(
                      leading: SizedBox(
                        width: 50,
                        height: 75,
                        child: Image.network(
                          book.cover,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(book.name),
                      subtitle: Text(book.author),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsScreen(book: book),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
