import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/provider/matrix_provider.dart';
import 'package:learn_english/view/play_game/features/2048/provider/score_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../../provider/theme_provider.dart';
import '../../../../../widgets/common_button.dart';
import '../../../../../widgets/common_showcase.dart';
import '../../../../shared_preference_service.dart';

class ButtonGroup extends StatefulWidget {
  final double buttonSize;
  final GlobalKey soundKey;
  final GlobalKey undoKey;
  final GlobalKey restartKey;
  final GlobalKey backKey;
  const ButtonGroup({
    required this.buttonSize,
    required this.soundKey,
    required this.undoKey,
    required this.restartKey,
    required this.backKey,
    Key? key,
  }) : super(key: key);

  @override
  _ButtonGroupState createState() => _ButtonGroupState();
}

class _ButtonGroupState extends State<ButtonGroup> {
  @override
  Widget build(BuildContext context) {
    double sizeOfBox = Constants.sizeOfBox(context);
    if (sizeOfBox > 500) sizeOfBox = 500;
    var theme = Provider.of<ThemeProviderGame>(context);
    var scoreProvider = ScoreProvider.of(context);
    var matrixProvider = MatrixProvider.of(context);
    return Container(
      margin: EdgeInsets.all(sizeOfBox * 0.05),
      height: 32,
      width: sizeOfBox,
      child: Row(
        children: [
          SizedBox(
            width: sizeOfBox * 0.4,
            child: Text(
              "Join the number \n& get to the 2048 title !",
              maxLines: 2,
              overflow: TextOverflow.fade,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    fontFamily: "Barlow",
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Theme.of(context).accentColor.withOpacity(0.8),
                  ),
            ),
          ),
          SizedBox(width: sizeOfBox * 0.1),
          SizedBox(
            width: sizeOfBox * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonShowcase(
                  showkey: widget.soundKey,
                  title: Constants.soundTitle,
                  description: Constants.soundDesc,
                  child: CommonButton(
                    imgPath: theme.isSoundOn == true
                        ? "assets/images/sound_button_on.svg"
                        : "assets/images/sound_button_off.svg",
                    onTap: () {
                      MatrixProvider.of(context).resetCell();
                      theme.changeSound();
                    },
                    isSoundButton: true,
                    size: widget.buttonSize,
                  ),
                ),
                const SizedBox(width: 8),
                Consumer<MatrixProvider>(builder: (context, matrix, child) {
                  return CommonShowcase(
                    showkey: widget.undoKey,
                    title: Constants.undoTitle,
                    description: Constants.undoDesc,
                    child: CommonButton(
                      isEnabled: isUndo(matrix),
                      imgPath: "assets/images/undo_button.svg",
                      onTap: () {
                        matrixProvider.undo();
                        if (matrixProvider.gameOver == false) {
                          scoreProvider.rollbackScore();
                        }
                      },
                      size: widget.buttonSize,
                    ),
                  );
                }),
                const SizedBox(width: 8),
                CommonShowcase(
                  showkey: widget.restartKey,
                  title: Constants.restartTitle,
                  description: Constants.restartDesc,
                  child: CommonButton(
                    imgPath: "assets/images/restart_button.svg",
                    onTap: () {
                      SharedPreferenceService.clearMatrix();
                      scoreProvider.updateHighScore();
                      scoreProvider.setCurScore(0);
                      matrixProvider.initializeGrid();
                      scoreProvider.scoreList.clear();
                    },
                    size: widget.buttonSize,
                  ),
                ),
                const SizedBox(width: 8),
                CommonShowcase(
                  showkey: widget.backKey,
                  description: Constants.backDesc,
                  title: Constants.backTitle,
                  child: CommonButton(
                    imgPath: "assets/images/back_button.svg",
                    onTap: () {
                      scoreProvider.scoreList.clear();
                      matrixProvider.history.clear();
                      Navigator.of(context).pop();
                    },
                    size: widget.buttonSize,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isUndo(matrixProvider) {
    bool undo = false;
    if (matrixProvider.history.length > 0 && matrixProvider.gameOver == false && matrixProvider.undoLeft > 0) {
      undo = true;
    }
    return undo;
  }
}
