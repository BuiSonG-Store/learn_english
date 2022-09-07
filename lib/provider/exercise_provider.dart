import 'package:flutter/material.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/exercise_model.dart';

class ExerciseProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  ExerciseModel? exerciseModel;
  Questions? questions;
  Answers? answers;
  Future<void> getData(String? id) async {
    var data = await appClient.get("/course/$id/exercise", token: true);
    exerciseModel = ExerciseModel.fromJson(data);
    notifyListeners();
  }
}
