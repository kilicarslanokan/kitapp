import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kitapp/riverpod/riverpod_management.dart';
import 'package:kitapp/views/home_screen.dart';
import 'package:kitapp/services/login_service.dart';

class LoginRiverpod extends ChangeNotifier {
  final service = LoginService();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final box= GetStorage();

  void fetch (BuildContext context, WidgetRef ref) async {
    final rememberMe = ref.read(rememberMeProvider); // Checkbox durumu

    service.loginCall(email: email.text, password: password.text).then((value) {
      if (value != null) {
        if (rememberMe) {
          box.write('token', value.actionLogin?.token); // Beni Hatırla seçiliyse token kaydet
        } else {
          box.remove('token'); // Seçili değilse önceki token'ı temizle
        }
        print('Token: ${value.actionLogin?.token}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen()
          )
        );
      }
      else {
        print('Giriş başarısız!');
      }
    });
  }
}