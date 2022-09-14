import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/exercise_model.dart';

class ExerciseProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();

  // ExerciseModel? exerciseModel;
  // Questions? questions;
  // Answers? answers;
  List<Questions> listQuestions = [];

  Future<void> getData(String? id) async {
    var data = await appClient.get("exercise/$id/questions", token: true);
    for (final obj in (data as List)) {
      listQuestions.add(Questions.fromJson(obj));
    }
    notifyListeners();
  }

  Future onFinishAnswer(int exerciseId) async {
    final bodyJson = {
      "name": injector<LocalApp>().getStringStorage(StringConst.userName),
      "score": listQuestions.length,
      "userId": injector<LocalApp>().getStringStorage(StringConst.id),
      "exerciseId": exerciseId
    };
    await appClient.post('user_score', body: bodyJson);
  }
}
