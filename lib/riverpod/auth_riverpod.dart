import 'package:flutter_riverpod/flutter_riverpod.dart';

// E-mail validasyon fonksiyonu
String? validateEmail(String email) {
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (email.isEmpty) {
    return 'E-mail boş bırakılamaz';
  } else if (!emailRegExp.hasMatch(email)) {
    return 'Geçerli bir e-mail giriniz';
  }
  return null; // Hata yok
}

// Şifre validasyon fonksiyonu
String? validatePassword(String password) {
  final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$');
  if (password.isEmpty) {
    return 'Şifre boş bırakılamaz';
  } else if (!passwordRegExp.hasMatch(password)) {
    return 'Şifre 6-20 karakter arasında ve alfanumerik olmalı';
  }
  return null; // Hata yok
}

String? validateName(String name) {
  if (name.isEmpty) {
    return 'İsim boş bırakılamaz';
  }
  return null; // Hata yok
}

// Riverpod Provider
final authProvider = Provider<AuthValidator>((ref) {
  return AuthValidator();
});

class AuthValidator {
  String? validateEmail(String email) => validateEmail(email);
  String? validatePassword(String password) => validatePassword(password);
}
