import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_english/view/play_game/features/2048/screen/menu_screen/widgets/button_group.dart';
import 'package:learn_english/view/play_game/features/2048/screen/menu_screen/widgets/high_score_board.dart';
import 'package:learn_english/view/play_game/widgets/common_button.dart';
import 'package:provider/provider.dart';
import '../../../../commons/common_image.dart';
import '../../../../config/constants.dart';
import '../../../../config/theme.dart';
import '../../../../provider/theme_provider.dart';
import '../../../../router/routing_name.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProviderGame>(context).themeData;
    Size size = MediaQuery.of(context).size;
    double sizeOfBox = Constants.sizeOfBox(context);
    if (sizeOfBox > 500) sizeOfBox = 500;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              SvgPicture.asset(
                theme == appThemeData[AppTheme.Dark]
                    ? 'assets/images/dark_theme_background.svg'
                    : 'assets/images/light_theme_background.svg',
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: sizeOfBox * 0.25,
                      width: sizeOfBox,
                      margin: EdgeInsets.only(top: sizeOfBox > 350 ? 10 : 6),
                      child: Image.asset("assets/images/game_bird_logo.png"),
                    ),
                    HighScoreBoard(textSize: getTextSize(sizeOfBox)),
                    ButtonGroupMenu(buttonSize: getButtonSize(sizeOfBox))
                  ],
                ),
              ),
              Positioned(
                top: 20,
                left: 20,
                child: SafeArea(
                  child: CommonButton(
                    imgPath: CommonImage.home,
                    onTap: () {
                      Navigator.of(context).pushNamed(RoutingNameGame.chooseGame);
                    },
                    size: getButtonSize(sizeOfBox),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double getButtonSize(double width) {
    if (width >= 350) {
      return 50;
    } else {
      return 40;
    }
  }

  double getTextSize(double width) {
    if (width >= 350) {
      return 8;
    } else {
      return 7;
    }
  }
}
