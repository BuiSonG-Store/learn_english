import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/global_app_cache/global_app_cache.dart';
import 'package:learn_english/common/manager/share_preference_service.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/common/network/configs.dart';
import 'package:learn_english/common/utils/common_util.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/user_model.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import '../view/widgets/loading/loading_process_builder.dart';

class CreateAccountProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AppClient appClient = injector<AppClient>();

  void sigUp(_) async {
    LoadingProcessBuilder.showProgressDialog(_);
    if (!CommonUtil.validateAndSave(formKey)) {
      LoadingProcessBuilder.hideProgressDialog(_);
      return;
    }
    final data = await register("register", _,
        body: {
          "username": nameController.text,
          "email": emailController.text.replaceAll,
          "password": passwordController.text,
        },
        formData: true,
        email: emailController.text);

    var model = UserModel.fromJson(data);
    if (model.email == null) {
      LoadingProcessBuilder.hideProgressDialog(_);
      CommonUtil.showSnackBar(_, title: "Create account not success!");
    }
  }
}

Future<Map<String, dynamic>> register(String endPoint, _,
    {dynamic body, bool formData = false, required String email}) async {
  var url = Uri.parse('${Configurations.host}$endPoint');
  Response? response;
  Map<String, dynamic> data = {};
  if (formData) {
    response = await http.post(url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(body));
    if (response.statusCode == 200) {
      LoadingProcessBuilder.hideProgressDialog(_);
      CommonUtil.showSnackBar(_,
          title: "Vui lòng xác nhận mã đã được gửi về gmail!",
          backgroundColor: Colors.yellow);
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(_, RoutingNameConstant.confirmEmail);
      });
      SharedPreferencesService.saveData(StringConst.email, email);
    } else if (response.statusCode == 400) {
      LoadingProcessBuilder.hideProgressDialog(_);
      CommonUtil.showSnackBar(_,
          title: "Email đã được đăng ký trước đó!",
          backgroundColor: Colors.yellow);
    }
  } else {
    response = await http.post(url, body: body);
  }
  if (response.body.isNotEmpty) {
    data = json.decode(response.body);
  }
  return data;
}

Future<Map<String, dynamic>> confirmEmail(String code, context) async {
  bool forRegister = GlobalAppCache.instance.forRegister;
  var url = Uri.parse('${Configurations.host}confirm/email/$code');
  Response? response;
  var data;
  try {
    LoadingProcessBuilder.showProgressDialog(context);
    response = await http.get(url);
    if (response.statusCode == 200) {
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context,
          title: forRegister
              ? "Xác nhận thành công, bạn có thể đăng nhập!"
              : 'Cập nhật thông tin thành công!',
          backgroundColor: Colors.green);
      Future.delayed(const Duration(seconds: 1), () {
        if (forRegister) {
          Navigator.pushReplacementNamed(
            context,
            RoutingNameConstant.logInScreen,
          );
        } else {
          Navigator.pop(context);
          Timer(Duration(milliseconds: 500), () {
            Navigator.pop(context);
          });
        }
      });
    }
    if (response.statusCode == 500) {
      LoadingProcessBuilder.hideProgressDialog(context);
      CommonUtil.showSnackBar(context,
          title: "Mã xác nhận sai, vui lòng thử lại!",
          backgroundColor: Colors.yellow);
    }
    return data;
  } catch (_) {
    return {};
  }
}
