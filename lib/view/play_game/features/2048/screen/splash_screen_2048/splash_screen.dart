import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/provider/matrix_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:provider/provider.dart';
import '../../../../config/constants.dart';
import '../../../../config/theme.dart';
import '../../../../provider/theme_provider.dart';
import '../../../shared_preference_service.dart';

class SplashScreen2048 extends StatefulWidget {
  const SplashScreen2048({Key? key}) : super(key: key);

  @override
  _SplashScreen2048State createState() => _SplashScreen2048State();
}

class _SplashScreen2048State extends State<SplashScreen2048> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Constants.isFirst = await SharedPreferenceService.getFirstTime();
      precacheImage(Image.asset("assets/images/leader_board_background.png").image, context);
      precacheImage(Image.asset("assets/images/score_background.png").image, context);
      MatrixProvider.of(context).initializeGrid();
      await Future.delayed(Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed(RoutingNameGame.menu);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProviderGame>(context).themeData;
    Constants.setSizeOfBox(MediaQuery.of(context).size.width);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Image.asset(
          theme == appThemeData[AppTheme.Dark]
              ? 'assets/images/dark_theme_splash.png'
              : 'assets/images/light_theme_splash.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
