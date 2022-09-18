class LoginModel {
  int? id;
  String? accessToken;
  String? type;
  String? username;
  String? level;
  String? email;
  String? refreshToken;
  List<dynamic>? roles;
  List<dynamic>? groupId;

  LoginModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accessToken = json['accessToken'];
    type = json['type'];
    username = json['username'];
    level = json['level'];
    email = json['email'];
    refreshToken = json['refreshToken'];
    roles = json['roles'];
    groupId = json['groupId'];
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
