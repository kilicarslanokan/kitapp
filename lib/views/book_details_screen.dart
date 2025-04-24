import 'package:flutter/material.dart';
import 'package:kitapp/models/book_model.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${book.name}', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 10),
            Text('Author: ${book.author}', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Price: \$${book.price}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}