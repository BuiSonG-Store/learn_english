import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../../../../widgets/background_item.dart';
import '../widgets/theme_setting_bar.dart';

class HomePageSlideParty extends StatelessWidget {
  const HomePageSlideParty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return Scaffold(
      body: ShowCaseWidget(
        disableBarrierInteraction: true,
        builder: Builder(
          builder: (context) => const BodyHome(),
        ),
      ),
    );
  }
}

class BodyHome extends StatefulWidget {
  const BodyHome({Key? key}) : super(key: key);

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  final GlobalKey _keyOne = GlobalKey();
  final GlobalKey _keyTwo = GlobalKey();
  final GlobalKey _keyThree = GlobalKey();
  final GlobalKey _keyFour = GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadShowCase();
  }

  _loadShowCase() async {
    bool isFirst = await SharedPreferenceService.getFirstTimeSlideParty();
    if (isFirst) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_keyOne, _keyTwo, _keyThree, _keyFour]),
      );
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    void _clickSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return Container(
      width: width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: ExactAssetImage('assets/backgrounds/background_home.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Image.asset(
                'assets/icons/png_logo_banner.png',
                width: width / 2,
              ),
              const Spacer(),
              Showcase(
                key: _keyFour,
                description: "Let's play",
                disposeOnTap: true,
                onTargetClick: () {
                  Navigator.of(context).pushNamed(RoutingNameGame.sMode);
                },
                child: Showcase(
                  key: _keyOne,
                  description: 'Tap to play single player mode',
                  child: InkWell(
                    onTap: () {
                      _clickSound();
                      Navigator.of(context).pushNamed(RoutingNameGame.sMode);
                    },
                    child: BackgroundItem(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 56,
                      widget: Text(
                        'SINGLE',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 18, letterSpacing: 5, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Showcase(
                key: _keyTwo,
                description: 'Tap to play multiple player mode',
                child: InkWell(
                  onTap: () {
                    _clickSound();
                    Navigator.of(context).pushNamed(RoutingNameGame.mMode);
                  },
                  child: BackgroundItem(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 56,
                    widget: Text(
                      'MULTIPLE',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontSize: 18, letterSpacing: 5, color: Colors.white),
                    ),
                  ),
                ),
              ),
              ThemeSettingBar(keyShow: _keyThree),
              const Gap(30),
            ],
          ),
        ],
      ),
    );
  }

  double getButtonSize(double width) {
    if (width >= 350) {
      return 50;
    } else {
      return 40;
    }
  }
}
