import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// E-mail validasyon fonksiyonu
String? validateEmail(String email, BuildContext context) {
  final d = AppLocalizations.of(context)!;
  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  if (email.isEmpty) {
    return d.emailEmpty;
  } else if (!emailRegExp.hasMatch(email)) {
    return d.emailValid;
  }
  return null; // Hata yok
}

// Şifre validasyon fonksiyonu
String? validatePassword(String password, BuildContext context) {
  final d = AppLocalizations.of(context)!;
  final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,20}$');
  if (password.isEmpty) {
    return d.pswdEmpty;
  } else if (!passwordRegExp.hasMatch(password)) {
    return d.pswdValid;
  }
  return null; // Hata yok
}

String? validateName(String name, BuildContext context) {
  final d = AppLocalizations.of(context)!;
  if (name.isEmpty) {
    return d.nameEmpty;
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
