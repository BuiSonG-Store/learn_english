import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/constants.dart';
import 'package:learn_english/view/play_game/features/2048/provider/matrix_provider.dart';
import 'package:learn_english/view/play_game/features/2048/provider/score_provider.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/common_button.dart';
import '../../../shared_preference_service.dart';

class GameOverMessage extends StatelessWidget {
  const GameOverMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scoreProvider = ScoreProvider.of(context);
    var matrixProvider = MatrixProvider.of(context);
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Theme.of(context).primaryColor,
        ),
        margin: EdgeInsets.only(left: Constants.sizeOfBox(context) * 0.05, right: Constants.sizeOfBox(context) * 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 25),
            Text(
              "Game over",
              maxLines: 1,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontFamily: "UTM Roman Classic",
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
            ),
            Consumer<ScoreProvider>(
              builder: (context, score, child) {
                return Text(
                  "You earned ${score.cur_score} points",
                  maxLines: 1,
                  overflow: TextOverflow.fade,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontFamily: "UTM Roman Classic",
                        fontSize: 14,
                        color: Theme.of(context).accentColor.withOpacity(0.8),
                        fontWeight: FontWeight.w400,
                      ),
                );
              },
            ),
            const SizedBox(height: 25),
            Container(
              padding: EdgeInsets.all(8),
              width: Constants.sizeOfBox(context),
              height: Constants.sizeOfBox(context) * 0.9,
              decoration:
                  BoxDecoration(image: DecorationImage(image: AssetImage(imagePath(context)), fit: BoxFit.cover)),
            ),
            const SizedBox(height: 15),
            Container(
              width: Constants.sizeOfBox(context) * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CommonButton(
                    imgPath: "assets/images/restart_button.svg",
                    onTap: () {
                      scoreProvider.scoreList.clear();
                      SharedPreferenceService.clearMatrix();
                      matrixProvider.initializeGrid();
                      scoreProvider.updateHighScore();
                      scoreProvider.setCurScore(0);
                      Navigator.of(context).pop();
                    },
                    size: 50,
                  ),
                  const SizedBox(width: 8),
                  CommonButton(
                    imgPath: "assets/images/back_button.svg",
                    onTap: () {
                      scoreProvider.scoreList.clear();
                      SharedPreferenceService.clearMatrix();
                      matrixProvider.initializeGrid();
                      scoreProvider.updateHighScore();
                      scoreProvider.setCurScore(0);
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    size: 50,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  String imagePath(BuildContext context) {
    var scoreProvider = ScoreProvider.of(context);
    if (scoreProvider.cur_score >= scoreProvider.highScore[2]) {
      return "assets/images/game_win.png";
    } else {
      return "assets/images/game_lose.png";
    }
  }
}
