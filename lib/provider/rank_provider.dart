import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/model/rank_model.dart';

class RankProvider extends ChangeNotifier {
  AppClient appClient = injector<AppClient>();
  String id = injector<LocalApp>().getStorage(StringConst.id);
  RankModel? rankModel;
  Future<void> getDataRank() async {
    var data = await appClient.get("user_score/$id", token: true);
    rankModel = RankModel.fromJson(data);
    notifyListeners();
  }
}
