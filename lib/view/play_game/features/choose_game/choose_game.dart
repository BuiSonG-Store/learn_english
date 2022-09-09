import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/common/constants/icons_const.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/features/choose_game/widget/control_bar_choose.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import '../../../../router/routing-name.dart';
import '../../commons/common_image.dart';
import '../../widgets/background_item.dart';

class ChooseGame extends StatefulWidget {
  const ChooseGame({Key? key}) : super(key: key);

  @override
  State<ChooseGame> createState() => _ChooseGameState();
}

class _ChooseGameState extends State<ChooseGame> {
  final _controller = PageController();
  static int pageIndex = 0;

  @override
  void initState() {
    pageIndex = 0;
    super.initState();
  }

  void onPlay() async {
    if (pageIndex == 0) {
      Navigator.of(context).pushNamed(RoutingNameConstant.homePageSlideParty);
    } else if (pageIndex == 1) {
      Navigator.of(context).pushNamed(RoutingNameConstant.splash2048);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    List<Widget> listImage = [
      Image.asset(
        CommonImage.icSlideParty,
        width: width,
      ),
      // Image.asset(
      //   CommonImage.ic2048,
      //   width: width,
      // ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            CommonImage.backGroundMain,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            width: width,
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 5,
                    child: PageView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (int index) {
                        setState(() {
                          pageIndex = index % listImage.length;
                        });
                      },
                      controller: _controller,
                      itemBuilder: (BuildContext context, int index) {
                        return listImage[index % listImage.length];
                      },
                    ),
                  ),
                  const Spacer(),
                  // ControlBarChoose(controller: _controller),
                  const SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
                        SoundController.playClickSoundSlideParty();
                      }
                      onPlay();
                    },
                    child: BackgroundItem(
                      height: 60,
                      width: width * 0.8,
                      widget: Text(
                        pageIndex == 0 ? 'PLAY SLIDE PARTY' : 'PLAY 2048 TIMEBIRD',
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(fontSize: 18, letterSpacing: 3, color: Colors.white, fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: GestureDetector(
                onTap: () {
                  SoundController.playClickSoundSlideParty();

                  Navigator.pushReplacementNamed(context, RoutingNameConstant.homeContainer);
                },
                child: Container(
                    height: 50,
                    width: 50,
                    padding: const EdgeInsets.all(12),
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.3), borderRadius: BorderRadius.circular(50)),
                    child: SvgPicture.asset('assets/icons/home.svg'))),
          )
        ],
      ),
    );
  }
}
