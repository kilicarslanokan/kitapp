import 'package:kitapp/riverpod/login_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kitapp/riverpod/register_riverpod.dart';

final loginRiverpod = ChangeNotifierProvider((_) => LoginRiverpod());
final registerProvider = ChangeNotifierProvider((_) => RegisterRiverpod());
final rememberMeProvider = StateProvider<bool>((ref) => false); // Checkbox için state ekledik
