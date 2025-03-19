import 'package:flutter/material.dart';
import 'package:kitapp/models/register_model.dart';
import 'package:kitapp/services/register_service.dart';

class RegisterRiverpod extends ChangeNotifier {
  final service = RegisterService();

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> register(BuildContext context) async {
    RegisterModel registerModel = RegisterModel(
      email: emailController.text,
      name: nameController.text,
      password: passwordController.text,
    );

    bool isRegistered = await service.registerCall(registerModel: registerModel);

    if (isRegistered) {
      print("Kayıt başarılı!");
      Navigator.pop(context); // Login ekranına geri döneriz.
    } else {
      print("Kayıt başarısız!");
    }
  }
}