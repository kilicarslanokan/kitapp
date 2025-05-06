import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/views/book_details_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryScreen extends ConsumerWidget {
  final dynamic category; // The category object
  final List<Book> books; // The books in the category

  const CategoryScreen({super.key, required this.category, required this.books});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final filteredBooks = searchQuery.isNotEmpty
        ? books.where((book) => book.name.toLowerCase().contains(searchQuery.toLowerCase())).toList()
        : books;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 50.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(category.name),
          ],
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/images/Filter.svg'),
                    ),
                    hintText: 'Search in ${category.name}',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                  },
                ),
              ),
              SizedBox(height: 15),
              Expanded(
                child: filteredBooks.isEmpty
                    ? Center(
                        child: Text(
                          'Aradığınız kitap bu kategoride bulunamadı.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2, // Two books per row
                            crossAxisSpacing: 8.0,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.6, // Adjusted aspect ratio for taller cards
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      AspectRatio(
                                        aspectRatio: 3 / 4, // Adjusted aspect ratio for better image fit
                                        child: Image.network(
                                          book.cover,
                                          width: double.infinity,
                                          fit: BoxFit.cover, // Ensure the image fills the card's width
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(10, 0, 8, 0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1, // Limit to a single line
                                              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                            ),
                                            const SizedBox(height: 2),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    book.author,
                                                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                    maxLines: 1, // Limit to a single line
                                                    overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                                                  ),
                                                ),
                                                Text(
                                                  '${book.price} \$',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.deepPurple,
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
