import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:provider/provider.dart';

class SettingSoundWidget extends StatelessWidget {
  const SettingSoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProviderGame>(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
      child: ListTileSwitch(
        value: theme.isSoundOn,
        onChanged: (bool value) {
          if (!Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
            SoundController.playClickSoundSlideParty();
          }
          theme.changeSound();
        },
        switchActiveColor: const Color(0xff25ADE6),
        title: Text('MUSIC', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
      ),
    );
  }
}
