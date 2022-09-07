import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/provider/score_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../config/constants.dart';
import '../../../../../widgets/common_showcase.dart';

class ScoreGroup extends StatefulWidget {
  final GlobalKey curScoreKey;
  final GlobalKey highScoreKey;
  const ScoreGroup({required this.highScoreKey, required this.curScoreKey, Key? key}) : super(key: key);

  @override
  _ScoreGroupState createState() => _ScoreGroupState();
}

class _ScoreGroupState extends State<ScoreGroup> {
  @override
  Widget build(BuildContext context) {
    double sizeOfBox = Constants.sizeOfBox(context);
    if (sizeOfBox > 500) sizeOfBox = 500;
    return Container(
      padding: EdgeInsets.fromLTRB(15, sizeOfBox == 500 ? 30 : 5, 15, 0),
      height: 150,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: sizeOfBox * 0.35,
            height: sizeOfBox * 0.3,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset("assets/images/game_bird_logo.png", fit: BoxFit.cover),
          ),
          Container(
            width: sizeOfBox * 0.55,
            height: sizeOfBox * 0.35,
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                CommonShowcase(
                  showkey: widget.highScoreKey,
                  title: Constants.highScoreTitle,
                  description: Constants.highScoreDesc,
                  child: Container(
                    width: sizeOfBox * 0.6,
                    height: sizeOfBox * 0.12,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).buttonColor.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: buildHighScore(context, sizeOfBox),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: CommonShowcase(
                    title: Constants.curScoreTitle,
                    description: Constants.curScoreDesc,
                    showkey: widget.curScoreKey,
                    child: Container(
                      padding: const EdgeInsets.only(left: 15, right: 20),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/score_background.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your \n Score",
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontFamily: "UTM Roman Classic",
                                  fontWeight: FontWeight.w600,
                                  fontSize: sizeOfBox > 350 ? 12 : 10,
                                  color: Colors.white,
                                ),
                          ),
                          Expanded(child: Container()),
                          Consumer<ScoreProvider>(
                            builder: (context, score, child) {
                              return Text(
                                score.cur_score.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.fade,
                                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                      fontFamily: "UTM Roman Classic",
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHighScore(BuildContext context, double sizeOfBox) {
    return Consumer<ScoreProvider>(
      builder: (context, score, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: sizeOfBox * 0.1,
              height: sizeOfBox * 0.1,
              child: Image.asset(getMedalPath(score)),
            ),
            const SizedBox(width: 5),
            Text(
              getHighScore(score) > 3 ? getHighScore(score).toString() : "--",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontFamily: "UTM Roman Classic",
                    fontSize: sizeOfBox > 350 ? 18 : 15,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
            ),
          ],
        );
      },
    );
  }

  int getHighScore(var scoreProvider) {
    if (scoreProvider.cur_score <= scoreProvider.highScore[2] && scoreProvider.highScore[2] != 1) {
      return scoreProvider.highScore[2];
    } else if (scoreProvider.cur_score <= scoreProvider.highScore[1] && scoreProvider.highScore[1] != 2) {
      return scoreProvider.highScore[1];
    } else if (scoreProvider.cur_score <= scoreProvider.highScore[0] && scoreProvider.highScore[0] != 3) {
      return scoreProvider.highScore[0];
    } else {
      return scoreProvider.cur_score;
    }
  }

  String getMedalPath(var scoreProvider) {
    if (scoreProvider.cur_score <= scoreProvider.highScore[2] && scoreProvider.highScore[2] != 1) {
      return "assets/images/bronze_medal.png";
    } else if (scoreProvider.cur_score <= scoreProvider.highScore[1] && scoreProvider.highScore[1] != 2) {
      return "assets/images/silver_medal.png";
    } else {
      return "assets/images/gold_medal.png";
    }
  }
}
