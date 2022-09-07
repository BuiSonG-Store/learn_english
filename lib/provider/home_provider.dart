import 'package:flutter/material.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/course_model.dart';

import '../common/constants/string_const.dart';

class HomeProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  CourseModel? courseModel;
  String id = injector<LocalApp>().getStorage(StringConst.id);
  TextEditingController controller = TextEditingController();
  final formKey = GlobalKey<FormState>();
  Future<void> getDataHome() async {
    /// lay data
    var data = await appClient.get("course?userId=$id", token: true);
    courseModel = CourseModel.fromJson(data);
    notifyListeners();
  }

  Future<void> search(String contentSearch) async {
    var data = await appClient.post(
      "course/search",
      body: {
        "filters": [
          {"key": "title", "operator": "LIKE", "field_type": "STRING", "value": "$contentSearch"}
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
