import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../config/theme.dart';
import '../../../../provider/theme_provider.dart';
import '../../helpers/sound_controller.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Provider.of<ThemeProviderGame>(context).themeData;
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    return Scaffold(
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
                children: [
                  const SizedBox(height: 25),
                  Container(
                    width: size.width * 0.6,
                    height: size.width * 0.6,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/game_bird_logo.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "About us",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontFamily: "UTM Roman Classic",
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).accentColor,
                        ),
                    overflow: TextOverflow.fade,
                  ),
                  Text(
                    "2048 Timebird",
                    maxLines: 1,
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          fontFamily: "UTM Roman Classic",
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).accentColor.withOpacity(0.8),
                        ),
                    overflow: TextOverflow.fade,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        "We are Timebird",
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: "UTM Roman Classic",
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Theme.of(context).accentColor.withOpacity(0.8),
                            ),
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () {
                      if (sound) {
                        SoundController.playSoundPress();
                      }
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(25, 5, 25, 5),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage("assets/images/score_background.png"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Back",
                            maxLines: 1,
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontFamily: "UTM Roman Classic",
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                            overflow: TextOverflow.fade,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
