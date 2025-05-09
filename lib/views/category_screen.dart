import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/views/book_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/widgets/colors.dart';

class CategoryScreen extends ConsumerWidget {
  final dynamic category;
  final List<Book> books;

  const CategoryScreen({super.key, required this.category, required this.books});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final filteredBooks = searchQuery.isNotEmpty
        ? books.where((book) => book.name.toLowerCase().contains(searchQuery.toLowerCase())).toList()
        : books;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(category.name, style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(12.0.w),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardRenk,
                    prefixIcon: Icon(Icons.search, color: Colors.black26),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(12.0.w),
                      child: SvgPicture.asset('assets/images/Filter.svg'),
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyle(color: Colors.black26, fontSize: 20.sp),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                ),
              ),
              SizedBox(height: 8.h),
              Expanded(
                child: filteredBooks.isEmpty
                    ? Center(
                        child: Text(
                          'Aradığınız kitap bu kategoride bulunamadı.',
                          style: TextStyle(fontSize: 16.sp, color: Colors.grey),
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: filteredBooks.length,
                          itemBuilder: (context, index) {
                            final book = filteredBooks[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BookDetailsScreen(book: book),
                                  ),
                                );
                              },
                              child: Card(
                                elevation: 3,
                                child: Padding(
                                  padding: EdgeInsets.only(top: 8.0.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 3 / 4,
                                        child: Image.network(
                                          book.cover,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.fromLTRB(10.w, 0, 8.w, 0),
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
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 2.h),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    book.author,
                                                    style: TextStyle(fontSize: 12.sp, color: textRenk2),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  '${book.price} \$',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: anaRenk,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
              ),
            ],
),
// Arama sonuçlarını göstermek için bir açılır liste
          // if (searchQuery.isNotEmpty)
          //   Positioned(
          //     top: 130,
          //     left: 8,
          //     right: 8,
          //     child: Material(
          //       elevation: 4.0,
          //       borderRadius: BorderRadius.circular(8.0),
          //       child: ListView.builder(
          //         shrinkWrap: true,
          //         itemCount: books.length,
          //         itemBuilder: (context, index) {
          //           final book = books[index];
          //           return ListTile(
          //             leading: SizedBox(
          //               width: 50,
          //               height: 75,
          //               child: Image.network(
          //                 book.cover,
          //                 fit: BoxFit.cover,
          //               ),
          //             ),
          //             title: Text(book.name),
          //             subtitle: Text(book.author),
          //             onTap: () {
          //               Navigator.push(
          //                 context,
          //                 MaterialPageRoute(
          //                   builder: (context) => BookDetailsScreen(book: book),
          //                 ),
          //               );
          //             },
          //           );
          //         },
          //       ),
          //     ),
          // ),
        ],
      ),
    );
  }
}
