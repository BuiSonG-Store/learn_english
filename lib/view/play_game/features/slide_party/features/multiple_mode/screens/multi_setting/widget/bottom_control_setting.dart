import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/background_item.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/dialogs/slideparty_snack_bar.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:provider/provider.dart';
import '../../../controllers/multiple_mode_controller.dart';

class BottomControlSetting extends StatelessWidget {
  final ValueNotifier boardChosen;
  final ValueNotifier playerChosen;
  final MultipleModeController controller;
  const BottomControlSetting(
      {Key? key, required this.boardChosen, required this.playerChosen, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    void _playSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return BackgroundItem(
      width: width * 0.8,
      height: 56,
      widget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              _playSound();
              Navigator.of(context).pushNamed(RoutingNameGame.homePageSlideParty);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SvgPicture.asset('assets/icons/home.svg'),
            ),
          ),
          InkWell(
            onTap: () {
              _playSound();
              final playerCount = playerChosen.value.indexOf(true);
              final boardSize = boardChosen.value.indexOf(true);
              if (playerCount != -1 && boardSize != -1) {
                controller.startGame(playerCount + 2, boardSize + 3);
              } else {
                showSlidepartyToast(
                  context,
                  'Select one layout!',
                  Colors.red,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: SvgPicture.asset('assets/icons/done.svg'),
            ),
          ),
        ],
      ),
    );
  }
}
