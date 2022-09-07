import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/view/play_game/config/constants.dart';
import 'package:learn_english/view/play_game/features/2048/screen/game_screen/widgets/button_group.dart';
import 'package:learn_english/view/play_game/features/2048/screen/game_screen/widgets/game_grid.dart';
import 'package:learn_english/view/play_game/features/2048/screen/game_screen/widgets/score_group.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:sizer/sizer.dart';

import '../../../../config/theme.dart';
import '../../../../provider/theme_provider.dart';
import '../../../shared_preference_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final GlobalKey _soundKey = GlobalKey();
  final GlobalKey _undoKey = GlobalKey();
  final GlobalKey _restartKey = GlobalKey();
  final GlobalKey _backKey = GlobalKey();
  final GlobalKey _gridKey = GlobalKey();
  final GlobalKey _curScoreKey = GlobalKey();
  final GlobalKey _highScoreKey = GlobalKey();
  late BuildContext mycontext;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bool isFirst = Constants.isFirst;
      if (isFirst) {
        ShowCaseWidget.of(mycontext).startShowCase([
          _soundKey,
          _undoKey,
          _restartKey,
          _backKey,
          _highScoreKey,
          _curScoreKey,
          _gridKey,
        ]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Provider.of<ThemeProviderGame>(context).themeData;
    return WillPopScope(
      onWillPop: () async => false,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          SizerUtil.orientation = orientation;
          return Scaffold(
            body: ShowCaseWidget(
              onFinish: () async {
                await SharedPreferenceService.setFirstTime();
              },
              builder: Builder(builder: (context) {
                mycontext = context;
                return SizedBox(
                  width: size.width,
                  height: size.height,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ScoreGroup(
                              curScoreKey: _curScoreKey,
                              highScoreKey: _highScoreKey,
                            ),
                            ButtonGroup(
                              buttonSize: getButtonSize(
                                Constants.sizeOfBox(context),
                              ),
                              restartKey: _restartKey,
                              soundKey: _soundKey,
                              backKey: _backKey,
                              undoKey: _undoKey,
                            ),
                            GameGrid(gridkey: _gridKey),
                            size.height < 600
                                ? Container()
                                : Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    height: size.height * 0.1,
                                    width: Constants.sizeOfBox(context),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Powered by",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                fontFamily: "UTM Roman Classic",
                                                letterSpacing: 2,
                                                fontSize: 10,
                                                color: Theme.of(context).accentColor.withOpacity(0.6),
                                              ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          "TIMEBIRD",
                                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                                fontFamily: "UTM Roman Classic",
                                                letterSpacing: 7,
                                                color: Theme.of(context).accentColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          );
        },
      ),
    );
  }

  double getButtonSize(double width) {
    if (width >= 350) {
      return 30;
    } else {
      return 25;
    }
  }
}
