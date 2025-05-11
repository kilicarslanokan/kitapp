import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kitapp/features/home/presentation/pages/home_screen.dart';
import 'package:kitapp/features/auth/presentation/pages/splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

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

        localizationsDelegates: const[               // DİL DESTEĞİ
          AppLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        supportedLocales: const[
          Locale("en",""),
          Locale("tr",""),
        ],                                        // DİL DESTEĞİ
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