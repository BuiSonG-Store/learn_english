import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';

import '../../widgets/background_item.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background_main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/png_logo_banner.png',
                width: width / 2,
              ),
              Column(
                children: [
                  Text('MATCH SAMPLE', style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 5)),
                  Text(
                    'TO WIN',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 5, fontSize: 30),
                  ),
                ],
              ),
              Image.asset(
                'assets/images/sample_to_win.png',
                width: width * 0.8,
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(RoutingNameGame.homePageSlideParty);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                  child: BackgroundItem(
                    width: width * 0.8,
                    height: 56,
                    widget:
                        Text("LET'S PLAY", style: Theme.of(context).textTheme.titleSmall?.copyWith(letterSpacing: 5)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
