import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kitapp/widgets/colors.dart';

class SearchTextField extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;

  const SearchTextField({
    super.key,
    required this.hintText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: cardRenk,
        prefixIcon: const Icon(Icons.search, color: Colors.black26),
        suffixIcon: Padding(
          padding: EdgeInsets.all(12.0.w),
          child: SvgPicture.asset('assets/images/Filter.svg'),
        ),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.black26, fontSize: 20.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4.0),
          borderSide: BorderSide.none,
        ),
      ),
      onChanged: onChanged,
    );
  }
}
