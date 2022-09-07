import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';

class SplashScreenSlideParty extends StatefulWidget {
  @override
  State<SplashScreenSlideParty> createState() => _SplashScreenSlidePartyState();
}

class _SplashScreenSlidePartyState extends State<SplashScreenSlideParty> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 1));
      Navigator.of(context).pushReplacementNamed(RoutingNameGame.homePageSlideParty);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/backgrounds/background_splash.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Positioned.fill(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset(
                    'assets/icons/ic_logo_timebird.png',
                    width: MediaQuery.of(context).size.width * 0.2,
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/icons/png_logo_banner.png',
                    alignment: Alignment.center,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
