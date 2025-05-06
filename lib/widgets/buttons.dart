import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/widgets/colors.dart';

class CustomButton extends StatelessWidget {
  //final String text;
  final Widget child;
  final VoidCallback onPressed;

  const CustomButton({super.key, required this.child, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: butonRenk,
        minimumSize: Size(
          390.w,
          50.h,
        ), // Responsive ölçü için w ve h değeri ekliyoruz
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: child
    );
  }
}
