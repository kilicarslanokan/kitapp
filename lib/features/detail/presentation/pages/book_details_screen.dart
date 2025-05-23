import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/features/home/data/models/book_model.dart';
import 'package:kitapp/widgets/buttons.dart';
import 'package:kitapp/widgets/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;

  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    var d = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 50.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              d.bookDetail,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(14.0.w),
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
                            height: 210.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 300.0,
                        child: Image.asset('assets/images/Heart.png'),
                      ),
                    ],
                  ),
                  SizedBox(height: 14.h),
                  // Book Name
                  Text(
                    book.name,
                    style: TextStyle(
                      color: textRenk,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 6.h),
                  // Author Name
                  Text(
                    book.author,
                    style: TextStyle(fontSize: 18.sp, color: textRenk2),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
                  // Summary Section
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      d.summary,
                      style: TextStyle(
                        fontSize: 20.sp,
                        color: textRenk,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    book.description.length > 350
                        ? '${book.description.substring(0, 350)}...'
                        : book.description,
                    style: TextStyle(fontSize: 15.sp, color: textRenk2),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0.w),
            child: CustomButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${book.price} ' + d.moneyType,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                  Text(
                    d.buyNow,
                    style: TextStyle(fontSize: 18.sp, color: Colors.white),
                  ),
                ],
              ),
              onPressed: () {
              },
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
