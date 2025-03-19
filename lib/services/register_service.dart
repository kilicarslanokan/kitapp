import 'package:dio/dio.dart';
import 'package:kitapp/models/register_model.dart';

class RegisterService {
  final String baseUrl = "https://assign-api.piton.com.tr/api/rest/";
  final dio = Dio();

  Future<bool> registerCall({required RegisterModel registerModel}) async {
    try {
      var response = await dio.post(
        baseUrl + "register",
        data: registerModel.toJson(),
      );

      if (response.statusCode == 200) {
        return true; // Kayıt başarılı
      } else {
        return false; // Kayıt başarısız
      }
    } catch (e) {
      print("Register error: $e");
      return false;
    }
  }
}
