import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kitapp/views/home_screen.dart';
import 'package:kitapp/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: _loginStatus(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return snapshot.data == true ? HomeScreen() : SplashScreen();
              }
            },
          ),
        );
      },
    );
  }
}
Future<bool> _loginStatus() async {
  final box = GetStorage();
  String? token = box.read("token");
  print('---------Token: $token');
  return token != null;
}