import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/controllers/multiple_mode_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/widget/control_bar.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/widget/swipe_detector_multi.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/widgets/win_dialog.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/controllers/playboard_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_state/playboard_state.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/widgets/playboard_view.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/widgets/skill_keyboard.dart';
import 'package:learn_english/view/play_game/features/slide_party/utils/app_infos/app_infos.dart';
import 'package:learn_english/view/play_game/features/slide_party/utils/durations.dart';
import 'package:line_icons/line_icon.dart';
import 'package:slideparty_socket/slideparty_socket_fe.dart';

double _playboardSize(BoxConstraints constraints) => min(constraints.biggest.shortestSide - 32, 375);

class MultiplePlayground extends HookConsumerWidget {
  const MultiplePlayground({Key? key}) : super(key: key);

  int axisLength(int playerCount) => playerCount ~/ 2 + (playerCount % 2 == 1 ? 1 : 0);

  int _flexSpace(int index, double ratio, playerCount) {
    if (ratio <= 1.3) return 1;
    if (index == axisLength(playerCount) - 1 && playerCount % 2 == 1) {
      return 1;
    } else {
      return 2;
    }
  }

  Axis _getDirectionOfParent(int index, {required bool preferVertical}) =>
      preferVertical ? Axis.horizontal : Axis.vertical;

  Axis _getDirectionOfChild(
    int index, {
    required BoxConstraints constraints,
    required bool preferVertical,
    required int playerCount,
  }) {
    if (preferVertical) {
      if (constraints.biggest.shortestSide > 600) {
        final ratio = constraints.maxHeight / constraints.maxWidth;
        if (ratio > 1.3) {
          return Axis.vertical;
        } else {
          return Axis.horizontal;
        }
      }
      if (constraints.biggest.height / playerCount < constraints.biggest.width / 2) {
        return Axis.horizontal;
      }
      return Axis.vertical;
    } else {
      if (constraints.maxHeight > 600) {
        final ratio = constraints.maxWidth / constraints.maxHeight;
        if (ratio > 1.3) {
          return Axis.horizontal;
        } else {
          return Axis.vertical;
        }
      }
      if (constraints.biggest.width / playerCount < constraints.biggest.height / 2) {
        return Axis.vertical;
      }
      return Axis.horizontal;
    }
  }

  Widget _multiplePlayerView(
    BuildContext context, {
    required bool preferVertical,
    required BoxConstraints constraints,
    required int playerCount,
  }) {
    final ratio = constraints.biggest.longestSide / constraints.biggest.shortestSide;
    return Flex(
      direction: preferVertical ? Axis.vertical : Axis.horizontal,
      children: List.generate(
        axisLength(playerCount),
        (index) => Flexible(
          flex: _flexSpace(index, ratio, playerCount),
          child: Flex(
            direction: _getDirectionOfParent(
              index,
              preferVertical: preferVertical,
            ),
            children: [
              Expanded(
                child: Flex(
                  direction: _getDirectionOfChild(
                    index,
                    constraints: constraints,
                    preferVertical: preferVertical,
                    playerCount: playerCount,
                  ),
                  children: List.generate(
                    playerCount % 2 == 1 && index == axisLength(playerCount) - 1 ? 1 : 2,
                    (colorIndex) => Expanded(
                      child: _PlayerPlayboardView(
                        index: index * 2 + colorIndex,
                        ratio: ratio,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showWinningDialog(
    BuildContext context,
    String whoWin,
    StateNotifier<PlayboardState> controller,
  ) {
    if (controller is MultipleModeController) {
      showDialog(
        context: context,
        builder: (context) => MultipleModeWinDialog(
          whoWin: whoWin,
          controller: controller,
        ),
        barrierDismissible: false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    final controller = ref.watch(playboardControllerProvider.notifier) as MultipleModeController;
    final playerCount = useMemoized(() {
      return ref.watch(
        playboardControllerProvider.select((value) => (value as MultiplePlayboardState).playerCount),
      );
    }, []);
    ref.listen<String?>(
      playboardControllerProvider.select(
        (value) => (value as MultiplePlayboardState).whoWin,
      ),
      (_, who) {
        if (who != null) {
          _showWinningDialog(context, who, controller);
        }
      },
    );
    final focusNode = useFocusNode();

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(image: ExactAssetImage('assets/backgrounds/background_multi.png'), fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            Focus(
              onKey: (FocusNode node, RawKeyEvent event) => KeyEventResult.handled,
              child: RawKeyboardListener(
                focusNode: focusNode,
                autofocus: true,
                onKey: (event) {
                  if (event is RawKeyDownEvent) {
                    controller.moveByKeyboard(event.logicalKey);
                  }
                },
                child: LayoutBuilder(
                  builder: (context, constraints) => _multiplePlayerView(
                    context,
                    preferVertical: constraints.maxWidth < constraints.maxHeight,
                    constraints: constraints,
                    playerCount: playerCount,
                  ),
                ),
              ),
            ),
            Positioned(
              child: Center(
                child: SizedBox(
                  width: 80,
                  height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/png_logo_banner.png',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: Consumer(
                          builder: (context, ref, child) {
                            final duration = ref.watch(counterMultiProvider);
                            return Text(
                              Durations.watchFormat(duration),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(color: Theme.of(context).colorScheme.primary),
                            );
                          },
                        ),
                      ),
                      ControlBarMulti(
                        controller: controller,
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _PlayerPlayboardView extends HookConsumerWidget {
  const _PlayerPlayboardView({
    Key? key,
    required this.index,
    required this.ratio,
  }) : super(key: key);

  final int index;
  final double ratio;

  bool _isLargeScreen(BoxConstraints constraints) => ratio > 1.3 && constraints.biggest.longestSide > 750;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerId = index.toString();
    final controller = ref.watch(playboardControllerProvider.notifier) as MultipleModeController;

    final view = RepaintBoundary(
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 500),
              tween: Tween<double>(begin: 0, end: 1),
              curve: Curves.easeInOutCubicEmphasized,
              child: SizedBox(
                child: Stack(
                  children: [
                    _MultipleMainPlayground(
                      playerId: playerId,
                      size: _playboardSize(constraints),
                      isLargeScreen: _isLargeScreen(constraints),
                    ),
                  ],
                ),
              ),
              builder: (context, value, child) => SizedBox(
                height: constraints.biggest.height * value,
                width: constraints.biggest.width * value,
                child: child,
              ),
            );
          },
        ),
      ),
    );

    if (AppInfos.screenType == ScreenTypes.touchscreen || AppInfos.screenType == ScreenTypes.touchscreenAndMouse) {
      return SwipeDetectorMulti(
        view: view,
        controller: controller,
        playerId: playerId,
      );
    }
    return view;
  }
}

class _MultipleMainPlayground extends HookConsumerWidget {
  const _MultipleMainPlayground({
    Key? key,
    required this.playerId,
    required this.size,
    required this.isLargeScreen,
  }) : super(key: key);

  final String playerId;
  final double size;
  final bool isLargeScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final controller = ref.watch(playboardControllerProvider.notifier) as MultipleModeController;
    final boardSize = ref.watch(
      playboardControllerProvider.select(
        (value) {
          value as MultiplePlayboardState;
          return value.boardSize;
        },
      ),
    );
    final affectedActions = ref.watch<List<SlidepartyActions>?>(
      playboardControllerProvider.select(
        (value) {
          value as MultiplePlayboardState;
          return value.currentAction(playerId);
        },
      ),
    )!;
    bool isPause = affectedActions.contains(SlidepartyActions.pause);

    return RepaintBoundary(
      child: Stack(
        children: [
          PlayboardView(
            boardSize: boardSize,
            size: size - 44,
            playerId: playerId,
            holeWidget: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: (number) {
              return controller.move(playerId, number);
            },
            clipBehavior: Clip.none,
          ),
          if (isPause) PauseAction(themeData: themeData, size: size),
          if (!isLargeScreen)
            Consumer(
              builder: (context, ref, child) {
                final show = ref.watch(
                  multipleSkillStateProvider(playerId).select(
                    (value) => value.show,
                  ),
                );
                return Center(
                  child: IgnorePointer(
                    ignoring: !show,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 100),
                      curve: Curves.easeInOutCubic,
                      opacity: show ? 1 : 0,
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class PauseAction extends StatelessWidget {
  const PauseAction({
    Key? key,
    required this.themeData,
    required this.size,
  }) : super(key: key);

  final ThemeData themeData;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: ColoredBox(
          color: themeData.scaffoldBackgroundColor.withOpacity(0.3),
          child: SizedBox(
            width: size + 32,
            height: size + 32,
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: themeData.scaffoldBackgroundColor,
                  shape: BoxShape.circle,
                  boxShadow: const [BoxShadow()],
                ),
                child: SizedBox(
                  height: 64,
                  width: 64,
                  child: Center(
                    child: LineIcon.pauseCircleAlt(size: 32),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
