import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/string_const.dart';
import 'package:learn_english/common/local/local_app.dart';
import 'package:learn_english/common/manager/share_preference_service.dart';
import 'package:learn_english/common/network/client.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:learn_english/router/routing-name.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    SoundController.initSound();
    _loadNextScreen();
    super.initState();
  }

  AppClient appClient = injector<AppClient>();

  _loadNextScreen() async {
    try {
      bool isFirst = await SharedPreferencesService.getFirstTime();
      var token = await injector<LocalApp>().getStorage(StringConst.keySaveToken);

      Future.delayed(const Duration(seconds: 2), () async {
        if (isFirst) {
          Navigator.pushNamedAndRemoveUntil(context, RoutingNameConstant.introScreen, (Route<dynamic> route) => false);
          return;
        } else {
          if (token != null && token != "") {
            appClient.makeRefreshToken();
            Navigator.pushNamedAndRemoveUntil(
                context, RoutingNameConstant.homeContainer, (Route<dynamic> route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, RoutingNameConstant.logInScreen, (Route<dynamic> route) => false);
          }
        }
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Image.asset(
            'assets/icons/logo.png',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
          Text('Easy English', style: Theme.of(context).textTheme.headline5),
          const Spacer(),
          Image.asset(
            'assets/gif/loading.gif',
            width: MediaQuery.of(context).size.width * 0.7,
          ),
        ],
      ),
    );
  }
}
