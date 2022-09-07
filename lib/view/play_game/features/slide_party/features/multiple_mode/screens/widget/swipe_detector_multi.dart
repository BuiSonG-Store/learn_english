import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/widgets.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../playboard/playboard.dart';

class SwipeDetectorMulti extends StatelessWidget {
  final controller;
  final Widget view;
  final String playerId;
  const SwipeDetectorMulti({Key? key, this.controller, required this.view, required this.playerId}) : super(key: key);

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
        controller.moveByGesture(playerId, PlayboardDirection.left);
      },
      onSwipeRight: () {
        _playSound();
        controller.moveByGesture(playerId, PlayboardDirection.right);
      },
      onSwipeUp: () {
        _playSound();
        controller.moveByGesture(playerId, PlayboardDirection.up);
      },
      onSwipeDown: () {
        _playSound();
        controller.moveByGesture(playerId, PlayboardDirection.down);
      },
      child: view,
    );
  }
}
