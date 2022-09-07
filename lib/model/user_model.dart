class UserModel {
  String? createAt;
  String? updateAt;
  String? username;
  String? password;
  String? email;
  int? age;
  dynamic qualification;
  String? verificationCode;
  bool? enabled;
  List<Roles>? roles;


  UserModel.fromJson(Map<String, dynamic> json) {
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    username = json['username'];
    password = json['password'];
    email = json['email'];
    age = json['age'];
    qualification = json['qualification'];
    verificationCode = json['verificationCode'];
    enabled = json['enabled'];
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['username'] = username;
    data['password'] = password;
    data['email'] = email;
    data['age'] = age;
    data['qualification'] = qualification;
    data['verificationCode'] = verificationCode;
    data['enabled'] = enabled;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  int? id;
  String? name;


  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}