import 'package:flutter/cupertino.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:provider/provider.dart';

class ScoreProvider with ChangeNotifier {
  int _curScore = 0;
  List<int> highScore = <int>[];
  List<int> scoreList = <int>[];

  int get cur_score => _curScore;

  static ScoreProvider of(BuildContext context) {
    return Provider.of<ScoreProvider>(context, listen: false);
  }

  void gainScoreAmount(int amount) async {
    scoreList.add(_curScore);
    _curScore += amount;
    setCurScore(_curScore);
    if (scoreList.length > 5) {
      scoreList.removeAt(0);
    }
    notifyListeners();
  }

  void setCurScore(int score) async {
    _curScore = score;
    await SharedPreferenceService.setCurScore(_curScore);
    notifyListeners();
  }

  Future<void> getCurScore() async {
    _curScore = await SharedPreferenceService.getCurScore();
    notifyListeners();
  }

  void rollbackScore() {
    if (scoreList.length > 0) {
      setCurScore(scoreList.last);
      scoreList.removeLast();
    }
  }

  void getHighScore() async {
    List<int> temp = await SharedPreferenceService.getHighScore();
    if (temp.isNotEmpty) {
      highScore += temp;
      highScore = highScore.toSet().toList();
      highScore = highScore..sort((a, b) => b.compareTo(a));
      highScore.sublist(0, 3);
      notifyListeners();
    } else {
      highScore = [3, 2, 1];
      notifyListeners();
    }
  }

  void setHighScore() async {
    await SharedPreferenceService.setHighScore(highScore);
  }

  void updateHighScore() {
    highScore.add(cur_score);
    highScore = highScore.toSet().toList();
    highScore = highScore..sort((a, b) => b.compareTo(a));
    highScore.sublist(0, 3);
    setHighScore();
    notifyListeners();
  }
}
