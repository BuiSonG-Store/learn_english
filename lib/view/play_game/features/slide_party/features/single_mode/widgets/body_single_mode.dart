import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/single_mode_setting/single_mode_setting.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/single_mode/widgets/widgets.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../../../router/routing-name.dart';
import '../../playboard/widgets/playboard_view.dart';
import '../controllers/single_mode_controller.dart';

class BodySingleMode extends StatefulWidget {
  final int boardSize;
  final double size;
  final SingleModePlayBoardController controller;
  bool openSetting;

  BodySingleMode({
    Key? key,
    required this.boardSize,
    required this.size,
    required this.controller,
    required this.openSetting,
  }) : super(key: key);

  @override
  State<BodySingleMode> createState() => _BodySingleModeState();
}

class _BodySingleModeState extends State<BodySingleMode> {
  final GlobalKey _keyOne = GlobalKey();
  final GlobalKey _keyTwo = GlobalKey();
  final GlobalKey _keyThree = GlobalKey();
  final GlobalKey _keyFour = GlobalKey();
  final GlobalKey _keyBoard = GlobalKey();
  final GlobalKey _keyFive = GlobalKey();
  final GlobalKey _keySix = GlobalKey();
  final GlobalKey _keySeven = GlobalKey();
  final GlobalKey _keyEight = GlobalKey();
  final GlobalKey _keyNine = GlobalKey();
  bool _isButtonTapped = false;
  @override
  void initState() {
    super.initState();
    _loadShowCase();
  }

  _loadShowCase() async {
    bool _isFirst = await SharedPreferenceService.getFirstTimeSlideParty();
    if (_isFirst) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([
          _keyOne,
          _keyTwo,
          _keyThree,
        ]),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    _onReset() {
      widget.controller.reset();
      setState(() => _isButtonTapped = !_isButtonTapped);
      if (sound) {
        SoundController.playClickSoundSlideParty();
      }
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isButtonTapped = !_isButtonTapped);
      });
    }

    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SingleModeHeader(
              keyFour: _keyFour,
              keyFive: _keyFive,
              keySix: _keySix,
            ),
            Showcase(
              key: _keyBoard,
              description: 'Tap to move the blocks from small to large to win!',
              child: PlayboardView(
                key: const ValueKey('single-mode-playboard'),
                size: widget.size - 24,
                onPressed: widget.controller.move,
                boardSize: widget.boardSize,
                clipBehavior: widget.openSetting ? Clip.antiAlias : Clip.none,
                holeWidget: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            SingleModeControlBar(
              keyNine: _keyNine,
              keySeven: _keySeven,
              keyEight: _keyEight,
              onReset: () => _isButtonTapped ? null : _onReset,
              onAuto: () => widget.controller.autoSolve(context, () {
                if (sound) {
                  SoundController.playClickSoundSlideParty();
                }
              }),
              onBackHome: () {
                if (sound) {
                  SoundController.playClickSoundSlideParty();
                }
                Navigator.of(context).pushReplacementNamed(RoutingNameConstant.homePageSlideParty);
              },
            ),
            const SizedBox(height: 30),
          ],
        ),
        if (widget.openSetting)
          SingleModeSetting(
            keyOne: _keyOne,
            keyTwo: _keyTwo,
            keyThree: _keyThree,
            handleClickStart: _handleStart,
          ),
      ],
    );
  }

  Future _handleStart() async {
    bool _isFirst = await SharedPreferenceService.getFirstTimeSlideParty();
    if (_isFirst) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        ShowCaseWidget.of(context)
            .startShowCase([_keyFour, _keyFive, _keySix, _keySeven, _keyEight, _keyNine, _keyBoard]);
        setState(() {
          widget.openSetting = false;
        });
      });
      SharedPreferenceService.setFirstTimeSlideParty();
    }
  }
}
