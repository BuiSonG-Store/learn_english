import 'package:flutter/cupertino.dart';

class Constants {
  static double? _sizeOfBox;

  static double sizeOfBox(BuildContext context) {
    if (_sizeOfBox == null) {
      _sizeOfBox = MediaQuery.of(context).size.width;
    }
    return _sizeOfBox ?? 350;
  }

  static void setSizeOfBox(double sizeWidth) {
    _sizeOfBox = sizeWidth;
    if (_sizeOfBox! > 500) _sizeOfBox = 500;
  }

  static bool isFirst = true;

  static String soundTitle = 'Sound adjust';
  static String soundDesc = "You can turn on/ turn off sound effects here";

  static String undoTitle = 'Undo';
  static String undoDesc = "You have 5 times to undo your move each game, use it wisely !";

  static String restartTitle = 'Restart';
  static String restartDesc = "New start, new opportunities ! And don't worry, if you get a high score in the last game, it will be saved";

  static String backTitle = 'Back';
  static String backDesc = "Back to menu screen";

  static String gridTitle = "Play ground";
  static String gridDesc = "Swipe in 4 directions to merge two cells with the same numbers";

  static String curScoreTitle = "Your score";
  static String curScoreDesc = "Your current score";

  static String highScoreTitle = "High score";
  static String highScoreDesc = "Try your best to beat high score !";
}
