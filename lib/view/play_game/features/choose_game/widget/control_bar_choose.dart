import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../commons/common_image.dart';

class ControlBarChoose extends StatefulWidget {
  final PageController controller;
  const ControlBarChoose({Key? key, required this.controller}) : super(key: key);

  @override
  State<ControlBarChoose> createState() => _ControlBarChooseState();
}

class _ControlBarChooseState extends State<ControlBarChoose> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    const kDuration = Duration(milliseconds: 300);
    const kCurve = Curves.easeInOut;
    bool isButtonTapped = true;
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    void _playSound() {
      if (sound) {
        SoundController.playSoundPress();
      }
    }

    void onNextPage() {
      widget.controller.nextPage(duration: kDuration, curve: kCurve);
      setState(() => isButtonTapped = false);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isButtonTapped = !isButtonTapped);
      });
    }

    void onPreviousPage() {
      widget.controller.previousPage(duration: kDuration, curve: kCurve);
      setState(() => isButtonTapped = false);
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => isButtonTapped = !isButtonTapped);
      });
    }

    return SizedBox(
      width: width * 0.85,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              isButtonTapped ? onPreviousPage() : null;
              _playSound();
            },
            icon: SvgPicture.asset(CommonImage.back),
          ),
          TextButton(
            onPressed: () {
              isButtonTapped ? onNextPage() : null;
              _playSound();
            },
            child: Text(
              'NEXT GAME',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(letterSpacing: 5, color: Colors.white, fontStyle: FontStyle.italic),
            ),
          ),
          IconButton(
            onPressed: () {
              isButtonTapped ? onNextPage() : null;
              _playSound();
            },
            icon: SvgPicture.asset(CommonImage.next),
          ),
        ],
      ),
    );
  }
}
