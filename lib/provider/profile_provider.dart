import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:learn_english/injector/injector_container.dart';

class ProfileProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();

  Future onUpdateUser(context, String userName, String level) async {
    try {
      String email =
          injector<LocalApp>().getStringStorage(StringConst.email) ?? '';
      String password =
          injector<LocalApp>().getStringStorage(StringConst.passwordLogin) ??
              '';
      await appClient.put('users?email=$email', body: {
        "username": userName,
        "email": email,
        "password": password,
        "level": level
      });
      CommonUtil.showSnackBar(context,
          title: 'Update thông tin thành công', color: Colors.green);
    } catch (e) {
      CommonUtil.showSnackBar(context,
          title: 'Đã xảy ra lỗi', color: Colors.orange);
    }
  }
}
