import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../../widgets/background_item.dart';

class ControlBarMulti extends StatefulWidget {
  final MultipleModeController controller;
  const ControlBarMulti({Key? key, required this.controller}) : super(key: key);

  @override
  State<ControlBarMulti> createState() => _ControlBarMultiState();
}

class _ControlBarMultiState extends State<ControlBarMulti> {
  bool _isButtonTapped = false;

  @override
  Widget build(BuildContext context) {
    void _onSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    void _onReset() {
      widget.controller.restart();
      setState(() => _isButtonTapped = true);
      _onSound();
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isButtonTapped = false);
      });
    }

    return BackgroundItem(
      width: 56,
      height: 140,
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              _onSound();
              widget.controller.goHome(context);
            },
            icon: SvgPicture.asset(
              'assets/icons/home.svg',
              height: 16,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => _isButtonTapped ? null : _onReset(),
            icon: SvgPicture.asset(
              'assets/icons/reload.svg',
              height: 16,
            ),
          ),
        ],
      ),
    );
  }
}
