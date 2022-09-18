import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/course_model.dart';
import 'package:learn_english/provider/loading_provider.dart';

import '../common/constants/string_const.dart';

class HomeProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  CourseModel? courseModel;

  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> getDataHome() async {
    List<dynamic> groupId = [];
    if (injector<LocalApp>().getStringStorage(StringConst.groupIds) != null) {
      groupId = jsonDecode(
          injector<LocalApp>().getStringStorage(StringConst.groupIds) ?? '');
    }
    String userId = injector<LocalApp>().getStorage(StringConst.id);
    var data = await appClient.post("course/all", body: {
      'userId': userId,
      'groupId': groupId,
    });
    courseModel = CourseModel.fromJson(data);
    notifyListeners();
  }

  Future<void> search(String contentSearch) async {
    var data = await appClient.post(
      "course/search",
      body: {
        "filters": [
          {
            "key": "title",
            "operator": "LIKE",
            "field_type": "STRING",
            "value": contentSearch
          }
        ],
        "sorts": [],
        "page": 0,
        "limit": 20
      },
      formData: true,
    );
    courseModel = CourseModel.fromJson(data);
    notifyListeners();
  }
}
