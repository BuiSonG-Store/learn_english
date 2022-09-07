import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/common/network/configs.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/log_in_model.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/widgets/loading/loading_process_builder.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class LogInProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  AppClient appClient = injector<AppClient>();

  void sigIn(_) async {
    try {
      LoadingProcessBuilder.showProgressDialog(_);
      if (!CommonUtil.validateAndSave(formKey)) {
        LoadingProcessBuilder.hideProgressDialog(_);
        return;
      }
      var data = await login("login", _,
          body: {
            "email": emailController.text.trim(),
            "password": passwordController.text,
          },
          formData: true);

      var model = LoginModel.fromJson(data);

      if (model.id != null) {
        /// lưu token.dart và refresh token.dart
        LoadingProcessBuilder.hideProgressDialog(_);

        injector<LocalApp>().saveStringStorage(StringConst.keySaveToken, model.accessToken ?? "");
        injector<LocalApp>().saveStringStorage(StringConst.keySaveReFreshToken, model.refreshToken ?? "");
        injector<LocalApp>().saveStringStorage(StringConst.userName, model.username ?? "");
        injector<LocalApp>().saveStringStorage(StringConst.email, model.email ?? "");
        injector<LocalApp>().saveStringStorage(StringConst.id, model.id.toString());

        /// đăng nhập thành công => navigate đến home

        CommonUtil.showSnackBar(_, title: "Log in success!");

        Navigator.pushReplacementNamed(_, RoutingNameConstant.homeContainer);
      } else {
        LoadingProcessBuilder.hideProgressDialog(_);

        return CommonUtil.showSnackBar(_, title: "Log in not success!");
      }
    } catch (_) {}
  }

  void signOut(context) {
    try {
      LoadingProcessBuilder.showProgressDialog(context);
      injector<LocalApp>().removeStorage(StringConst.keySaveToken);
      injector<LocalApp>().removeStorage(StringConst.keySaveReFreshToken);
      injector<LocalApp>().removeStorage(StringConst.userName);
      injector<LocalApp>().removeStorage(StringConst.email);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.logInScreen, (Route<dynamic> route) => false);
      });
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context, title: "Log out success!");
    } catch (_) {}
  }
}

Future<Map<String, dynamic>> login(String endPoint, context, {dynamic body, bool formData = false}) async {
  var url = Uri.parse('${Configurations.host}$endPoint');
  Response? response;
  Map<String, dynamic> data = {};
  if (formData) {
    response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body));
    if (response.statusCode == 400) {
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context, title: "Email không hợp lệ!");
    }
    if (response.statusCode == 401) {
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context, title: "Sai tài khoản hoặc mật khẩu!");
    }
    if (response.statusCode == 500) {
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context, title: "500");
    }
  } else {
    response = await http.post(url, body: body);
  }
  if (response.body.isNotEmpty) {
    data = json.decode(response.body);
  }
  return data;
}
