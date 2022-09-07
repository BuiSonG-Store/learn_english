import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/multi_setting/widget/bottom_control_setting.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/multi_setting/widget/select_layout_multi.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/controllers/playboard_controller.dart';
import 'package:learn_english/view/play_game/widgets/setting_sound_wdget.dart';

class MultipleSetting extends HookConsumerWidget {
  const MultipleSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final controller = ref.watch(playboardControllerProvider.notifier) as MultipleModeController;
    final playerChosen = useState([true, false, false]);
    final boardChosen = useState([false, false, false]);

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: ExactAssetImage('assets/backgrounds/background_main.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/png_logo_banner.png',
                  width: width / 2,
                ),
                Column(
                  children: [
                    Text('MULTIPLE',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 3, color: Colors.white)),
                    Text(
                      'SETTING',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(letterSpacing: 5, fontSize: 30, color: Colors.white),
                    )
                  ],
                ),
                const SettingSoundWidget(),
                SelectLayoutMulti(playerChosen: playerChosen, boardChosen: boardChosen),
                BottomControlSetting(
                  playerChosen: playerChosen,
                  boardChosen: boardChosen,
                  controller: controller,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
