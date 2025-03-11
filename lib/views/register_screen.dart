import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/widgets/colors.dart';

void main() => runApp(const RegisterScreen());

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset("assets/images/Logo.png",width: 100.w,height: 65.h),
          centerTitle: true,
          toolbarHeight: 100.h,
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardRenk,
                    hintText: "John Doe",hintStyle: TextStyle(color: Colors.black26, fontSize: 20.sp),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("E-mail",style: TextStyle(color: textRenk,fontSize: 20.sp,)),
                SizedBox(height: 5.h,),
                TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardRenk,
                    hintText: "john@mail.com",hintStyle: TextStyle(color: Colors.black26, fontSize: 20.sp),
                    border: InputBorder.none,
                  ),
                ),
                SizedBox(height: 10.h,),
                Text("Password",style: TextStyle(color: textRenk,fontSize: 20.sp),),
                SizedBox(height: 5.h,),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: cardRenk,
                    hintText: "●●●●●●●●",hintStyle : TextStyle(color: Colors.black26, fontSize: 20.sp,fontWeight: FontWeight.bold,),
                    border: InputBorder.none,
                  ),
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
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: butonRenk,
                      minimumSize: Size(390, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 20.sp),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}