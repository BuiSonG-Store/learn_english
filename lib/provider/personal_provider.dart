import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import '../injector/injector_container.dart';

class PersonalProvider extends ChangeNotifier {
  Future<void> getData(String? id) async {
    injector<LocalApp>().getStorage(StringConst.avt);
  }
}
