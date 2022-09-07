import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../../../widgets/background_item.dart';
import '../../playboard/controllers/playboard_controller.dart';
import '../controllers/single_mode_controller.dart';

class SingleModeControlBar extends ConsumerWidget {
  final GlobalKey keySeven;
  final GlobalKey keyEight;
  final GlobalKey keyNine;
  final Function onReset;
  final Function onAuto;
  final Function onBackHome;
  const SingleModeControlBar({
    Key? key,
    required this.keySeven,
    required this.keyEight,
    required this.keyNine,
    required this.onReset,
    required this.onAuto,
    required this.onBackHome,
  }) : super(key: key);

  double _rSpacing(double playboardSize, int boardSize) => 2.5 * _tileSize(playboardSize, boardSize) / 49;

  double _tileSize(double playboardSize, int boardSize) => playboardSize / boardSize;

  double maxPlayboardSize(double screenSize, int boardSize) => screenSize - 16 - 2 * _rSpacing(screenSize, boardSize);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(playboardControllerProvider.notifier) as SingleModePlayBoardController;
    final state = ref.watch(playboardControllerProvider) as SinglePlayboardState;
    final screenSize = MediaQuery.of(context).size;

    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: maxPlayboardSize(
          min(425, screenSize.shortestSide),
          state.playboard.size,
        ),
      ),
      child: BackgroundItem(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 56,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (controller.isSolving == false) ...[
              IconButton(
                onPressed: () => onBackHome(),
                icon: Showcase(
                  key: keySeven,
                  description: 'You can back home page!',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/icons/home.svg',
                      height: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              TextButton(
                onPressed: () => onAuto(),
                child: Showcase(
                  key: keyEight,
                  description: 'You can turn on auto play!',
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'AUTO',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
            IconButton(
              onPressed: onReset(),
              icon: Showcase(
                key: keyNine,
                description: 'You can replay game!',
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    'assets/icons/reload.svg',
                    height: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
