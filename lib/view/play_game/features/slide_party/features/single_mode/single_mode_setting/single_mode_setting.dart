import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/single_mode_setting/widget/bottom_bar_setting.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/single_mode_setting/widget/select_layout.dart';
import 'package:learn_english/view/play_game/widgets/setting_sound_wdget.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../playboard/controllers/playboard_controller.dart';
import '../controllers/single_mode_controller.dart';

class SingleModeSetting extends ConsumerWidget {
  final GlobalKey keyOne;
  final GlobalKey keyTwo;
  final GlobalKey keyThree;
  final Function handleClickStart;
  const SingleModeSetting({
    Key? key,
    required this.keyOne,
    required this.keyTwo,
    required this.keyThree,
    required this.handleClickStart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double width = MediaQuery.of(context).size.width;
    final size = ref.watch(playboardControllerProvider.select((state) {
      if (state is SinglePlayboardState) {
        return state.playboard.size;
      }
      throw Exception('SingleModeSetting: state is not SinglePlayboardState');
    }));
    final controller = ref.watch(playboardControllerProvider.notifier) as SingleModePlayBoardController;
    final openSettingController = ref.watch(singleModeSettingProvider.notifier);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/backgrounds/background_main.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              'assets/icons/png_logo_banner.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            Column(
              children: [
                Text('SINGLE',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(letterSpacing: 5, color: Colors.white)),
                Text(
                  'SETTING',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(letterSpacing: 5, fontSize: 30, color: Colors.white),
                )
              ],
            ),
            Showcase(
              key: keyOne,
              description: 'You can also turn the volume on or off here!',
              child: const SettingSoundWidget(),
            ),
            Showcase(
              key: keyTwo,
              description: 'Choose one of the layouts here!',
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SELECT LAYOUT', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SelectLayout(
                          controller: controller,
                          boxNumber: 3,
                          width: width / 4 - 20,
                          size: size,
                          urlImage: 'assets/images/box3x3.png',
                        ),
                        SelectLayout(
                          controller: controller,
                          boxNumber: 4,
                          width: width / 3 - 20,
                          size: size,
                          urlImage: 'assets/images/box4x4.png',
                        ),
                        SelectLayout(
                          controller: controller,
                          boxNumber: 5,
                          width: width / 2.5 - 20,
                          size: size,
                          urlImage: 'assets/images/box5x5.png',
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            BottomBarSetting(
              keyThree: keyThree,
              controller: openSettingController,
            )
          ],
        ),
      ),
    );
  }
}
