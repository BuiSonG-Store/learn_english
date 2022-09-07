import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:provider/provider.dart';

import '../../../../widgets/background_item.dart';
import '../../../2048/helpers/sound_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const String content =
        "This website stores cookies on your computer. These cookies are used to improve your website experience and provide more personalized services to you, both on this website and through other media.\n\nTo find out more about the cookies we use, see our Privacy Policy. We won't track your information when you visit our site. But in order to comply with your preferences, we'll have to use just one tiny cookie so that you're not asked to make this choice again.";
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/background_main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Container(
              color: Colors.black.withOpacity(0.4),
            ),
            SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/png_logo_banner.png',
                    width: width / 2,
                  ),
                  Text(
                    'ABOUT US',
                    style: Theme.of(context).textTheme.headline6?.copyWith(fontSize: 30, color: Colors.white),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SLIDES PARTY BY TIMEBIRD TEAM',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.grey),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                    child: Text(
                      content,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white),
                    ),
                  ),
                  Text(
                    'POWERED BY',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall
                        ?.copyWith(color: Colors.grey, letterSpacing: 4, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'TIMEBIRD',
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(letterSpacing: 8, fontStyle: FontStyle.italic, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () {
                      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
                        SoundController.playClickSoundSlideParty();
                      }
                      Navigator.of(context).pushReplacementNamed(RoutingNameGame.homePageSlideParty);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                      child: BackgroundItem(
                        width: width * 0.8,
                        height: 56,
                        widget: Text('BACK',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 18, color: Colors.white)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
