import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/features/auth/data/models/register_model.dart';
import 'package:kitapp/features/auth/data/services/register_service.dart';

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
final registerProvider = ChangeNotifierProvider((_) => RegisterRiverpod());
