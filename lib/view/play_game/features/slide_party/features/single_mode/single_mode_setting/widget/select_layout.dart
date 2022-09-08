import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/controllers/single_mode_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class SelectLayout extends StatelessWidget {
  final SingleModePlayBoardController controller;
  final int boxNumber;
  final double width;
  final int size;
  final String urlImage;
  const SelectLayout(
      {Key? key,
      required this.controller,
      required this.boxNumber,
      required this.width,
      required this.size,
      required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _playSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return GestureDetector(
      onTap: () {
        _playSound();
        controller.changeDimension(boxNumber);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            urlImage,
            width: width,
            color: size == boxNumber ? const Color(0xff4980FF) : Colors.white.withOpacity(0.3),
          ),
          Positioned(
            child: Text(
              '$boxNumber x $boxNumber',
              style: TextStyle(fontSize: boxNumber * 4, color: Colors.white, shadows: const [
                Shadow(
                  blurRadius: 12,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
