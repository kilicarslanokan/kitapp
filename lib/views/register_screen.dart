import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/riverpod/auth_riverpod.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/widgets/buttons.dart';
import 'package:kitapp/widgets/colors.dart';
import 'package:kitapp/widgets/text_fields.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.h),
          child: Form(
            key: _formKey,
            child: Container(
              width: double.infinity,
              height: 670.h,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h),
                  Center(
                    child: Image.asset(
                      "assets/images/Logo.png",
                      width: 100.w,
                      height: 65.h,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    "Welcome",
                    style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                  ),
                  Text(
                    "Register an account",
                    style: TextStyle(
                      color: textRenk,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 50.h),
                  Text(
                    "Name",
                    style: TextStyle(color: textRenk, fontSize: 20.sp),
                  ),
                  SizedBox(height: 5.h),
                  CostumeTextField(
                    obscureText: false,
                    controller: ref.read(registerProvider).nameController,
                    hintText: "John Doe",
                    validator: (value) => validateName(value ?? ""),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "E-mail",
                    style: TextStyle(color: textRenk, fontSize: 20.sp),
                  ),
                  SizedBox(height: 5.h),
                  CostumeTextField(
                    obscureText: false,
                    controller: ref.read(registerProvider).emailController,
                    hintText: "john@mail.com",
                    validator: (value) => validateEmail(value ?? ""),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Password",
                    style: TextStyle(color: textRenk, fontSize: 20.sp),
                  ),
                  SizedBox(height: 5.h),
                  CostumeTextField(
                    obscureText: true,
                    controller: ref.read(registerProvider).passwordController,
                    hintText: "●●●●●●●●",
                    validator: (value) => validatePassword(value ?? ""),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: anaRenk, fontSize: 15.sp),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  CustomButton(
                    child: Center(
                      child: Text(
                        "Register",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                        ),
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref.read(registerProvider).register(context);
                      }
                    },
                  ),
                  SizedBox(height: 10.h), // TAŞARSA BURAYI DÜZELT
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
