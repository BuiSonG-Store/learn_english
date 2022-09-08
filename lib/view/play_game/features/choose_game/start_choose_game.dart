import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import '../../../../router/routing-name.dart';
import '../../commons/common_image.dart';
import '../../widgets/background_item.dart';
import 'package:provider/provider.dart';

class StartChooseGame extends StatefulWidget {
  const StartChooseGame({Key? key}) : super(key: key);

  @override
  State<StartChooseGame> createState() => _StartChooseGameState();
}

class _StartChooseGameState extends State<StartChooseGame> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SoundController.initSound();
      bool sound = await SharedPreferenceService.getSound();
      Provider.of<ThemeProviderGame>(context, listen: false).setSound(sound);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            CommonImage.backGroundHome,
            width: width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.fill,
          ),
          SafeArea(
            child: SizedBox(
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      if (sound) {
                        SoundController.playClickSoundSlideParty();
                      }
                      Navigator.of(context).pushReplacementNamed(RoutingNameConstant.chooseGame);
                    },
                    child: BackgroundItem(
                        widget: Text(
                          'SELECT GAME',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontSize: 18, letterSpacing: 3, color: Colors.white, fontStyle: FontStyle.italic),
                        ),
                        width: width * 0.8),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
