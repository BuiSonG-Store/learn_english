import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../config/constants.dart';
import '../../../../../config/theme.dart';
import '../../../../../provider/theme_provider.dart';
import '../../../../../widgets/common_button.dart';
import '../../../helpers/sound_controller.dart';

class ButtonGroupMenu extends StatelessWidget {
  final double buttonSize;

  const ButtonGroupMenu({required this.buttonSize, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Provider.of<ThemeProviderGame>(context);
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    return SizedBox(
      width: Constants.sizeOfBox(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              if (sound) {
                SoundController.playSoundPress();
              }
              Navigator.of(context).pushNamed("/game-screen");
            },
            child: SizedBox(
              width: Constants.sizeOfBox(context) * 0.5,
              child: Image.asset("assets/images/play_button.png", fit: BoxFit.fitWidth),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: Constants.sizeOfBox(context) * 0.6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CommonButton(
                  imgPath: theme.themeData == appThemeData[AppTheme.Light]
                      ? "assets/images/theme_button_light.svg"
                      : "assets/images/theme_button_dark.svg",
                  onTap: () {
                    if (theme.themeData == appThemeData[AppTheme.Light]) {
                      theme.setTheme(AppTheme.Dark);
                    } else {
                      theme.setTheme(AppTheme.Light);
                    }
                  },
                  size: buttonSize,
                ),
                CommonButton(
                  imgPath: theme.isSoundOn == true
                      ? "assets/images/sound_button_on.svg"
                      : "assets/images/sound_button_off.svg",
                  onTap: () {
                    theme.changeSound();
                  },
                  isSoundButton: true,
                  size: buttonSize,
                ),
                CommonButton(
                  imgPath: "assets/images/about_button.svg",
                  onTap: () {
                    Navigator.of(context).pushNamed('/about-screen');
                  },
                  size: buttonSize,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
