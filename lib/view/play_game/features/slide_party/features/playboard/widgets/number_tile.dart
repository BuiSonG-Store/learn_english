import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/models/slideparty_button_params.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/slideparty_button.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../config/sound_controller.dart';

class NumberTile extends StatelessWidget {
  const NumberTile({
    Key? key,
    required this.index,
    required this.color,
    required this.playboardSize,
    required this.boardSize,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final int index;
  final ButtonColors color;
  final double playboardSize;
  final int boardSize;
  final Function(int index) onPressed;
  final Widget child;

  double get _rSpacing => 3 * _tileSize / 49;
  double get _tileSize => playboardSize / boardSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(index),
      child: SizedBox(
        height: _tileSize,
        width: _tileSize,
        child: Padding(
          padding: EdgeInsets.all(_rSpacing),
          child: SlidepartyButton(
            color: color,
            size: ButtonSize.square,
            scale: _tileSize / 49,
            onTap: () {
              if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
                SoundController.playClickSoundSlideParty();
              }
              onPressed(index);
            },
            child: child,
          ),
        ),
      ),
    );
  }
}
