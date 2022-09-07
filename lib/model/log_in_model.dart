class LoginModel {
  int? id;
  String? accessToken;
  String? type;
  String? username;
  String? email;
  String? refreshToken;
  List<dynamic>? roles;

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    type = json['type'];
    username = json['username'];
    email = json['email'];
    refreshToken = json['refreshToken'];
    roles = json['roles'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['accessToken'] = accessToken;
    data['type'] = type;
    data['username'] = username;
    data['email'] = email;
    data['refreshToken'] = refreshToken;
    data['roles'] = roles;
    return data;
  }
}
