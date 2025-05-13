import 'package:dio/dio.dart';
import 'package:kitapp/features/auth/data/models/login_model.dart';

class LoginService {
  final String baseUrl = "https://assign-api.piton.com.tr/api/rest/";
  final dio = Dio();
  Future<LoginModel?> loginCall({
    required String email,
    required String password,
  }) async {
    Map<String, dynamic> json = {
      "email": email,
      "password": password,
    };
    var response = await dio.post(baseUrl + "login", data: json);
    if (response.statusCode == 200) {
      var result = LoginModel.fromJson(response.data);
      return result;
    } else {
      throw ("Bir sorun oluştu! ${response.statusCode}");
    }
  }
}
