class LoginModel {
  ActionLogin? actionLogin;

  LoginModel({this.actionLogin});

  LoginModel.fromJson(Map<String, dynamic> json) {
    actionLogin = json['action_login'] != null
        ? ActionLogin.fromJson(json['action_login'])
        : null;
  }

  get token => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (actionLogin != null) {
      data['action_login'] = actionLogin!.toJson();
    }
    return data;
  }
}

class ActionLogin {
  String? token;

  ActionLogin({this.token});

  ActionLogin.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['token'] = token;
    return data;
  }
}
