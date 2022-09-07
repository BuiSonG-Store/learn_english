import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../2048/helpers/sound_controller.dart';
import '../../../widgets/background_item.dart';

class ThemeSettingBar extends StatelessWidget {
  GlobalKey keyShow;
  ThemeSettingBar({Key? key, required this.keyShow}) : super(key: key);

  double delayedProgress(int length, double animationValue, int i) =>
      ((animationValue * length.toDouble()) - (i / length)).clamp(0, 1).toDouble();

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProviderGame>(context);
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    void _playSound() {
      if (sound) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Center(
        child: BackgroundItem(
          width: MediaQuery.of(context).size.width * 0.8,
          height: 56,
          widget: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _playSound();
                  Navigator.of(context).pushNamed(RoutingNameGame.chooseGame);
                },
                icon: Image.asset(
                  'assets/icons/game_home.png',
                  height: 26,
                  color: const Color(0xff25ADE6),
                ),
              ),
              Showcase(
                key: keyShow,
                description: 'Tap to turn volume on or off',
                child: SizedBox(
                  height: 49,
                  width: 49,
                  child: IconButton(
                    onPressed: () {
                      if (!sound) {
                        SoundController.playClickSoundSlideParty();
                      }
                      theme.changeSound();
                    },
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 3000),
                      transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                      child: SvgPicture.asset('assets/icons/volume.svg',
                          height: 20, color: theme.isSoundOn ? const Color(0xff25ADE6) : const Color(0xff707070)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 49,
                width: 49,
                child: IconButton(
                  onPressed: () {
                    _playSound();
                    Navigator.of(context).pushNamed(RoutingNameGame.aboutUsSlideParty);
                  },
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 3000),
                    transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
                    child: SvgPicture.asset('assets/icons/nav.svg', height: 20, color: const Color(0xff25ADE6)),
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
