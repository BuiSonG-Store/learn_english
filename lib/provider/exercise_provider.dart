import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/exercise_model.dart';

class ExerciseProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();

  List<Questions> listQuestions = [];

  Future<void> getData(String? id) async {
    listQuestions.clear();
    var data = await appClient.get("exercise/$id/questions", token: true);
    for (final obj in (data as List)) {
      listQuestions.add(Questions.fromJson(obj));
      if (listQuestions.length == 2) {
        break;
      }
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
    listQuestions.clear();
    await appClient.post('user_score', body: bodyJson);
  }

  void updateListQuestionWhenWrong(int index) {
    final model = listQuestions[index];
    for (int i = 0; i < (model.answers?.length ?? 0); i++) {
      model.answers![i].isSelected = false;
    }
    listQuestions.add(model);
    notifyListeners();
  }
}
