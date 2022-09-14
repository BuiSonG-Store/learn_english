import 'package:flutter/material.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/details_course.dart';

import '../common/constants/string_const.dart';

class CourseDetailsProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  String id = injector<LocalApp>().getStorage(StringConst.id);
  List<dynamic> listData = [];
  final formKey = GlobalKey<FormState>();

  Future<void> getData(String id) async {
    var data = await appClient.get("course/$id/exercise", token: true);
    for (final obj in (data as List)) {
      final model = DetailsCourseModel.fromJson(obj);
      listData.add(model);
    }
    notifyListeners();
  }
}
