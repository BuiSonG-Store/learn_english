import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/provider/score_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import 'high_score_item.dart';

class HighScoreBoard extends StatelessWidget {
  const HighScoreBoard({required this.textSize, Key? key}) : super(key: key);

  final double textSize;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeOfBox = Constants.sizeOfBox(context);
    if (sizeOfBox > 500) sizeOfBox = 500;
    return Container(
      height: sizeOfBox * 0.92,
      margin: EdgeInsets.fromLTRB(sizeOfBox * 0.15, 5, sizeOfBox * 0.15, 0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.asset("assets/images/leader_board_background.png"),
          Consumer<ScoreProvider>(builder: (context, score, child) {
            return Positioned(
              top: sizeOfBox * 0.37,
              child: SizedBox(
                width: sizeOfBox * 0.45,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: sizeOfBox * 0.5,
                      child: Image.asset("assets/images/high_score_title.png", fit: BoxFit.fitWidth),
                    ),
                    const SizedBox(height: 3),
                    HighScoreItem(
                      score: score.highScore[0],
                      medalPath: "assets/images/gold_medal.png",
                      backgrPath: "assets/images/gold_medal_background.svg",
                      ranking: 1,
                      textSize: textSize,
                    ),
                    HighScoreItem(
                      score: score.highScore[1],
                      medalPath: "assets/images/silver_medal.png",
                      backgrPath: "assets/images/silver_medal_background.svg",
                      ranking: 2,
                      textSize: textSize,
                    ),
                    HighScoreItem(
                      score: score.highScore[2],
                      medalPath: "assets/images/bronze_medal.png",
                      backgrPath: "assets/images/bronze_medal_background.svg",
                      ranking: 3,
                      textSize: textSize,
                    ),
                    SizedBox(height: size.height * 0.08),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
