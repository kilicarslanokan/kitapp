import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/views/book_details_screen.dart';
import 'package:kitapp/views/category_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Tüm Kitapları başlangıçta bir kez yükle
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/images/Logo.png', height: 40),
            const Text("Catalog"),
          ],
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
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
                            style: ElevatedButton.styleFrom(
                              foregroundColor: selectedCategoryId == 0 ? Colors.white : Colors.deepPurple,
                              backgroundColor: selectedCategoryId == 0 ? Colors.deepPurple : Colors.white,
                            ),
                            child: Text('All'),
                          ),
                          ...categories.map((category) {
                            final isSelected = selectedCategoryId == category.id;
                            return ElevatedButton(
                              onPressed: () {
                                ref.read(selectedCategoryProvider.notifier).state = category.id;
                              },
                              style: ElevatedButton.styleFrom(
                                foregroundColor: isSelected ? Colors.white : Colors.deepPurple,
                                backgroundColor: isSelected ? Colors.deepPurple : Colors.white,
                              ),
                              child: Text(category.name),
                            );
                          }).toList(),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, color: Colors.deepPurple),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset('assets/Filter.svg'),
                    ),
                    hintText: 'Search',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onChanged: (value) {
                    ref.read(searchQueryProvider.notifier).state = value;
                    ref.read(searchProvider.notifier).searchBooks(value);
                  },
                ),
                const SizedBox(height: 15),
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
                        return Center(child: Text('Loading..'));
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
                                padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      category.name,
                                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                                        "View All",
                                        style: TextStyle(color: Colors.deepPurple),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 160, // Kartların yüksekliği
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
                                        width: 250, // Kartın genişliği
                                        margin: const EdgeInsets.only(right: 12),
                                        child: Card(
                                          elevation: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                Image.network(
                                                  book.cover,
                                                  width: 90,
                                                  height: 150,
                                                  fit: BoxFit.cover,
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          book.name,
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                          maxLines: 2,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const SizedBox(height: 4),
                                                        Text(
                                                          book.author,
                                                          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                                          maxLines: 1,
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        const Spacer(),
                                                        Text(
                                                          '${book.price} \$',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            color: Colors.deepPurple,
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
                              const SizedBox(height: 16),
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
