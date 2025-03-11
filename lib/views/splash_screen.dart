import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kitapp/views/login_screen.dart';
import 'package:kitapp/widgets/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textRenk,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Image.asset("assets/images/Logo.png"),
          Align(alignment: Alignment.center),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: butonRenk,
                minimumSize: Size(390, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 20.sp),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 65.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: textRenk,
                minimumSize: Size(390, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: Text(
                "Skip",
                style: TextStyle(color: anaRenk, fontSize: 15.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
