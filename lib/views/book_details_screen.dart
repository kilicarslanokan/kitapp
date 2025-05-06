import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/models/book_model.dart';
import 'package:kitapp/widgets/buttons.dart';
import 'package:kitapp/widgets/colors.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              'Book Details',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6.0),
                          child: Image.network(
                            book.cover,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0, // İkonun üstte sabit kalması için
                        left: 330.0, // İkonun sağda sabit kalması için
                        child: Image.asset('assets/images/Heart.png'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Book Name
                  Text(
                    book.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  // Author Name
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 18.sp, color: textRenk2),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),

                  // Summary Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Summary',
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: textRenk,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    book.description.length > 400
                        ? '${book.description.substring(0, 400)}...'
                        : book.description,
                    style: TextStyle(fontSize: 15.sp, color: textRenk2),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${book.price} \$",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                  Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 20.sp, color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
                // Add buy functionality here
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
