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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false,  // Klavye açıldığında butonun kaymasını önler
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("assets/images/Logo.png",width: 100.w,height: 65.h),
          centerTitle: true,
          toolbarHeight: 90.h,
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 50.h,),
                  Text("Welcome", style: TextStyle(color: Colors.black87,fontSize: 15.sp),),
                  Text("Register an account", style: TextStyle(color: textRenk,fontSize: 20.sp,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50.h,),
                  Text("Name",style: TextStyle(color: textRenk,fontSize: 20.sp,)),
                  SizedBox(height: 5.h,),
                  CostumeTextField(
                    obscureText: true,
                    controller: ref.read(registerProvider).nameController,
                    hintText: "John Doe",
                    validator: (value) => validateName(value ?? ""),
                  ),
                  SizedBox(height: 10.h,),
                  Text("E-mail",style: TextStyle(color: textRenk,fontSize: 20.sp,)),
                  SizedBox(height: 5.h,),
                  CostumeTextField(
                    obscureText: true,
                    controller: ref.read(registerProvider).emailController,
                    hintText: "john@mail.com",
                    validator: (value) => validateEmail(value ?? ""),
                  ),
                  SizedBox(height: 10.h,),
                  Text("Password",style: TextStyle(color: textRenk,fontSize: 20.sp),),
                  SizedBox(height: 5.h,),
                  CostumeTextField(
                    obscureText: false,
                    controller: ref.read(registerProvider).passwordController,
                    hintText: "●●●●●●●●",
                    validator: (value) => validatePassword(value ?? ""),
                  ),
                  Row( 
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(onPressed: () {
                        Navigator.pop(context);
                      }, child: Text('Login',style: TextStyle(color: anaRenk,fontSize: 15.sp))),
                    ],
                  ),
                  SizedBox(height: 50.h,),    // TAŞARSA BURAYI DÜZELT
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomButton(
                      text: "Register",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.read(registerProvider).register(context);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}