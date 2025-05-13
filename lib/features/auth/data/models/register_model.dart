class RegisterModel {
  String? email;
  String? name;
  String? password;

  RegisterModel({this.email, this.name, this.password});

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "name": name,
      "password": password,
    };
  }
}
