import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/riverpod/auth_riverpod.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/views/register_screen.dart';
import 'package:kitapp/widgets/buttons.dart';
import 'package:kitapp/widgets/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/widgets/text_fields.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
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
                      "Welcome back!",
                      style: TextStyle(color: Colors.black87, fontSize: 15.sp),
                    ),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        color: textRenk,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.h),
                    Text(
                      "E-mail",
                      style: TextStyle(color: textRenk, fontSize: 20.sp),
                    ),
                    SizedBox(height: 5.h),
                    CostumeTextField(
                      obscureText: false,
                      controller: ref.read(loginRiverpod).email,
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
                      controller: ref.read(loginRiverpod).password,
                      hintText: "●●●●●●●●",
                      validator: (value) => validatePassword(value ?? ""),
                    ),
                    Row(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final rememberMe = ref.watch(
                              rememberMeProvider,
                            ); // Provider'dan mevcut state'i oku
                            return Checkbox(
                              value:
                                  rememberMe, // Checkbox'ın mevcut durumunu ata
                              onChanged: (bool? newValue) {
                                ref.read(rememberMeProvider.notifier).state =
                                    newValue!; // Durumu güncelle
                              },
                              activeColor: anaRenk,
                              side: BorderSide(color: anaRenk, width: 2),
                            );
                          },
                        ),
                        Text(
                          'Remember Me',
                          style: TextStyle(color: anaRenk, fontSize: 15.sp),
                        ),
                        Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Register',
                            style: TextStyle(color: anaRenk, fontSize: 15.sp),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(
                        child: Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.sp,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ref.read(loginRiverpod).fetch(context, ref);
                          }
                        },
                    ),
                    SizedBox(height: 10.h,),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    
  }
}
