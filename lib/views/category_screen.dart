import 'package:flutter/material.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/views/book_details_screen.dart';

class CategoryScreen extends StatelessWidget {
  final dynamic category; // The category object
  final List<Book> books; // The books in the category

  const CategoryScreen({super.key, required this.category, required this.books});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two books per row
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            childAspectRatio: 0.6, // Adjusted aspect ratio for taller cards
          ),
          itemCount: books.length,
          itemBuilder: (context, index) {
            final book = books[index];
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
    );
  }
}
