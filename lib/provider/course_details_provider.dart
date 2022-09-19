import 'package:flutter/material.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/details_course.dart';

import '../common/constants/string_const.dart';

class CourseDetailsProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  String id = injector<LocalApp>().getStorage(StringConst.id);
  DetailsCourseModel? detailsCourseModel;
  final formKey = GlobalKey<FormState>();

  Future<void> getData(String id) async {
    var data = await appClient.get("course/2/exercise", token: true);
    detailsCourseModel = DetailsCourseModel.fromJson(data);

    notifyListeners();
  }
}
