import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/playboard.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/theme_provider.dart';
import '../../../../../config/sound_controller.dart';
import '../../../widgets/swipe_detector.dart';

class SwipeDetectorWidget extends StatelessWidget {
  final controller;
  final Widget widget;
  const SwipeDetectorWidget({Key? key, required this.controller, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _playSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return SwipeDetector(
      onSwipeLeft: () {
        _playSound();
        controller.moveByGesture(PlayboardDirection.left);
      },
      onSwipeRight: () {
        _playSound();
        controller.moveByGesture(PlayboardDirection.right);
      },
      onSwipeUp: () {
        _playSound();
        controller.moveByGesture(PlayboardDirection.up);
      },
      onSwipeDown: () {
        _playSound();
        controller.moveByGesture(PlayboardDirection.down);
      },
      child: widget,
    );
  }
}
