import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:learn_english/view/play_game/widgets/background_item.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

class BottomBarSetting extends StatelessWidget {
  final GlobalKey keyThree;
  final controller;
  const BottomBarSetting({Key? key, required this.keyThree, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _playSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return BackgroundItem(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 56,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _playSound();
              Navigator.of(context).pushReplacementNamed(RoutingNameGame.homePageSlideParty);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SvgPicture.asset('assets/icons/home.svg'),
            ),
          ),
          Showcase(
            key: keyThree,
            description: 'Tap to start play!',
            disposeOnTap: false,
            onTargetClick: () async {
              await SharedPreferenceService.setFirstTimeSlideParty();
              controller.state = false;
            },
            child: InkWell(
              onTap: () {
                _playSound();
                controller.state = false;
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: SvgPicture.asset('assets/icons/done.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
