import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitapp/views/book_details_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsyncValue = ref.watch(categoryProvider);
    final selectedCategoryId = ref.watch(selectedCategoryProvider);
    final bookAsyncValue = ref.watch(bookProvider(selectedCategoryId));
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
                const SizedBox(height: 10),
                Expanded(
                  child: bookAsyncValue.when(
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (err, stack) => Center(child: Text('Hata: $err')),
                    data: (books) {
                      if (books.isEmpty) {
                        return Center(child: Text('Veri bulunamadı.'));
                      }
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: books.map((book) {
                              return Card(
                                margin: const EdgeInsets.symmetric(vertical: 8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        book.cover,
                                        width: 100,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                      SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              book.name,
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              book.author,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              '${book.price} \$',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.deepPurple,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
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
