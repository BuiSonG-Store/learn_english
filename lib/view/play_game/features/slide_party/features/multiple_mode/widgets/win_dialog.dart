import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/models/slideparty_button_params.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/dialogs/slideparty_dialog.dart';

class MultipleModeWinDialog extends StatelessWidget {
  const MultipleModeWinDialog({
    Key? key,
    required this.whoWin,
    required this.controller,
  }) : super(key: key);

  final String whoWin;
  final MultipleModeController controller;

  @override
  Widget build(BuildContext context) {
    final _whoWin = int.parse(whoWin) + 1;

    return Center(
      child: Material(
        color: Colors.transparent,
        child: Theme(
          data: ButtonColors.values[_whoWin].adaptiveTheme(context),
          child: SlidepartyDialog(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.width * 0.4,
            title: 'Winner!!!',
            description: 'PLAYER $_whoWin WINNER!',
            content: Image.asset(
              'assets/images/win_multi.png',
              width: double.infinity,
            ),
            actions: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                  controller.restart();
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    'assets/icons/reload_dialog.svg',
                    width: 40,
                  ),
                ),
              ),
              InkWell(
                onTap: () => controller.goHome(context),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: SvgPicture.asset(
                    'assets/icons/close.svg',
                    width: 40,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
