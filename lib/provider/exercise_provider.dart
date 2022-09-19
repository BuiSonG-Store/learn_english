import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/exercise_model.dart';

class ExerciseProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  Questions? questions;

  Future<void> getData(String? id) async {
    questions?.content?.clear();
    var data = await appClient.get("exercise/$id/questions", token: true);
    questions = Questions.fromJson(data);
    notifyListeners();
  }

  Future onFinishAnswer(int exerciseId) async {
    final bodyJson = {
      "name": injector<LocalApp>().getStringStorage(StringConst.userName),
      "score": questions?.content?.length,
      "userId": injector<LocalApp>().getStringStorage(StringConst.id),
      "exerciseId": exerciseId
    };
    questions?.content?.clear();
    await appClient.post('user_score', body: bodyJson);
  }

  // void updateListQuestionWhenWrong(int index) {
  //   final model = listQuestions[index];
  //   for (int i = 0; i < (model.answers?.length ?? 0); i++) {
  //     model.answers![i].isSelected = false;
  //   }
  //   listQuestions.add(model);
  //   notifyListeners();
  // }
  void updateListQuestionWhenWrong(int index) {
    final model = questions?.content?[index];
    for (int i = 0; i < (model?.answers?.length ?? 0); i++) {
      model?.answers![i].isSelected = false;
    }
    questions?.content?.add(model!);
    notifyListeners();
  }
}
