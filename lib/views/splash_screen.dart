import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kitapp/views/home_screen.dart';
import 'package:kitapp/views/login_screen.dart';
import 'package:kitapp/widgets/colors.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
    final box = GetStorage();

  @override
  void initState() {
    // eğer bir token yoksa login ekranına git, varsa home ekranına git
    Future.delayed(const Duration(seconds: 3), () {
      if (box.read("token")!=null) {
        Navigator.pushReplacement(
          context,  
          MaterialPageRoute(
            builder: (context) => HomeScreen()
          )
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen()
          )
        );
      }
    });
    super.initState();
  }

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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: butonRenk,
                minimumSize: Size(330.w, 50.h),
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
            padding: EdgeInsets.only(bottom: 30.h),
            child: TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: textRenk,
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
