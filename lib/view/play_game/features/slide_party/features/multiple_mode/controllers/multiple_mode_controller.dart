import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/controllers/playboard_controller.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/helpers/playboard_keyboard_control_helper.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_config.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_keyboard_control.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_skill_keyboard_control.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_state/playboard_state.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/playboard.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/widgets/skill_keyboard.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/models/slideparty_button_params.dart';
import 'package:learn_english/view/play_game/router/routing_name.dart';
import 'package:slideparty_socket/slideparty_socket_fe.dart';

final multipleModeControllerProvider =
    StateNotifierProvider.autoDispose<PlayboardController, PlayboardState>((ref) => MultipleModeController(ref.read));
final counterMultiProvider = StateProvider.autoDispose<Duration>((ref) => const Duration(seconds: 0));

class MultipleModeController extends PlayboardController<MultiplePlayboardState> with PlayboardKeyboardControlHelper {
  MultipleModeController(this._read)
      : super(
          MultiplePlayboardState(
            playerCount: 0,
            playerStates: const {},
            boardSize: 3,
          ),
        );

  final Reader _read;
  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  Map<String, PlayboardSkillKeyboardControl> _keyboardControls = {};

  PlayboardSkillKeyboardControl playerControl(String index) => _keyboardControls[index]!;
  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void restart() {
    state = MultiplePlayboardState(
      boardSize: state.boardSize,
      playerCount: state.playerCount,
    );
    stopwatch
      ..stop()
      ..reset();
    timer?.cancel();
    timer = null;
    _read(counterMultiProvider.notifier).state = const Duration(seconds: 0);
  }

  void goHome(BuildContext context) {
    Navigator.of(context).pushNamed(RoutingNameGame.homePageSlideParty);
  }

  void startGame(int player, int boardSize) {
    switch (player) {
      case 2:
        _keyboardControls = {
          '0': PlayboardSkillKeyboardControl(
            control: wasdControl,
            activeSkillKey: LogicalKeyboardKey.keyX,
          ),
          '1': PlayboardSkillKeyboardControl(
            control: arrowControl,
            activeSkillKey: LogicalKeyboardKey.space,
          ),
        };
        break;
      default:
    }

    state = MultiplePlayboardState(
      playerCount: player,
      boardSize: boardSize,
    );
  }

  void pickAction(String index, SlidepartyActions action) {
    final openSkillState = _read(multipleSkillStateProvider(index));
    final openSkillNotifier = _read(multipleSkillStateProvider(index).notifier);
    if (openSkillState.usedActions[action] == true) return;

    switch (action) {
      case SlidepartyActions.clear:
        if (state.currentAction(index).isNotEmpty) {
          final configs = state.config as MultiplePlayboardConfig;
          state = state.setActions(
            index,
            [],
            configs.changeConfig(
              index.toString(),
              NumberPlayboardConfig(ButtonColors.values[int.parse(index)]),
            ),
          );
          openSkillNotifier.state = openSkillState.copyWith(
            show: false,
            usedActions: {
              ...openSkillState.usedActions,
              SlidepartyActions.clear: true,
            },
          );
          return;
        }
        break;
      default:
        openSkillNotifier.state = openSkillState.copyWith(queuedAction: action);
    }
  }

  void doAction(String index, String target) {
    _flushAction(index, target);
    _removeQueuedAction(index, target);
  }

  void _removeQueuedAction(String index, String target) async {
    final openSkillState = _read(multipleSkillStateProvider(index));
    final openSkillNotifier = _read(multipleSkillStateProvider(index).notifier);
    final queuedAction = openSkillState.queuedAction!;

    state = state.setActions(
      target,
      [...state.currentAction(target), queuedAction],
    );

    openSkillNotifier.state = openSkillState.copyWith(
      queuedAction: null,
      show: false,
      usedActions: {
        ...openSkillState.usedActions,
        queuedAction: true,
      },
    );

    if (queuedAction == SlidepartyActions.blind) {
      state = state.setConfig(
        target,
        BlindPlayboardConfig(
          (state.config as MultiplePlayboardConfig).configs[target.toString()]!.mapOrNull(
                blind: (c) => c.color,
                number: (c) => c.color,
              )!,
        ),
      );
      await Future.delayed(
        const Duration(seconds: 10),
        () => state = state.setConfig(
          target,
          NumberPlayboardConfig(
            (state.config as MultiplePlayboardConfig).configs[target.toString()]!.mapOrNull(
                  blind: (c) => c.color,
                  number: (c) => c.color,
                )!,
          ),
        ),
      );
    }
  }

  void _flushAction(String index, String target) async {
    final openSkillState = _read(multipleSkillStateProvider(index));
    final queuedAction = openSkillState.queuedAction!;

    await Future.delayed(
      const Duration(seconds: 10),
      () {
        state = state.setActions(
          target,
          [...state.currentAction(target)]..remove(queuedAction),
        );
      },
    );
  }

  bool handleSkillKey(
    PlayboardSkillKeyboardControl control,
    String index,
    LogicalKeyboardKey pressedKey,
  ) {
    final openSkillState = _read(multipleSkillStateProvider(index));
    final openSkillNotifier = _read(multipleSkillStateProvider(index).notifier);
    final otherPlayersIndex = state.getPlayerIds(index.toString());

    if (openSkillState.show) {
      if (control.activeSkillKey == pressedKey) {
        openSkillNotifier.state = openSkillState.copyWith(
          show: false,
          queuedAction: null,
        );
        return true;
      }
      if (openSkillState.queuedAction == null) {
        control.control.onKeyDown(
          pressedKey,
          onLeft: () => pickAction(index, SlidepartyActions.blind),
          onDown: () => pickAction(index, SlidepartyActions.pause),
          onRight: () => pickAction(index, SlidepartyActions.clear),
        );
      } else {
        control.control.onKeyDown(
          pressedKey,
          onLeft: () {
            _flushAction(index, otherPlayersIndex[0]);
            _removeQueuedAction(index, otherPlayersIndex[0]);
          },
          onDown: () {
            if (otherPlayersIndex.length < 2) return;
            _flushAction(index, otherPlayersIndex[1]);
            _removeQueuedAction(index, otherPlayersIndex[1]);
          },
          onRight: () {
            if (otherPlayersIndex.length < 3) return;
            _flushAction(index, otherPlayersIndex[2]);
            _removeQueuedAction(index, otherPlayersIndex[2]);
          },
        );
      }
      return true;
    }

    if (pressedKey == control.activeSkillKey) {
      openSkillNotifier.state = openSkillState.copyWith(show: !openSkillState.show);
      return true;
    }
    return false;
  }

  bool handleKeyboardControl(
    PlayboardSkillKeyboardControl control,
    String index,
    LogicalKeyboardKey pressedKey,
  ) {
    final singleState = state.currentState(index);
    final newBoard = defaultMoveByKeyboard(
      control.control,
      pressedKey,
      singleState.playboard,
    );

    if (newBoard != null) {
      state = state.setState(
        index,
        singleState.editPlayboard(newBoard),
      );
      return true;
    }
    return false;
  }

  bool willBlockControl(String index) {
    final singleState = state.currentAction(index);
    return singleState.contains(SlidepartyActions.pause);
  }

  @override
  void moveByKeyboard(LogicalKeyboardKey pressedKey) {
    if (state.whoWin != null) return;
    _keyboardControls.forEach(
      (index, control) {
        final handled = handleSkillKey(control, index, pressedKey);
        if (willBlockControl(index)) return;
        if (!handled) handleKeyboardControl(control, index, pressedKey);
      },
    );
  }

  void move(String index, int number) {
    if (state.whoWin != null) return;
    if (willBlockControl(index)) return;
    final singleState = state.currentState(index);
    final newBoard = singleState.playboard.move(number);
    if (newBoard != null) {
      state = state.setState(index, singleState.editPlayboard(newBoard));
      updatePlayboardState(newBoard);
    }
  }

  void moveByGesture(String index, PlayboardDirection direction) {
    if (state.whoWin != null) return;
    if (willBlockControl(index)) return;
    final singleState = state.currentState(index);
    final newBoard = singleState.playboard.moveHole(direction);
    if (newBoard != null) {
      state = state.setState(index, singleState.editPlayboard(newBoard));
      updatePlayboardState(newBoard);
    }
  }

  void updatePlayboardState(Playboard playboard) {
    if (timer == null) {
      stopwatch.start();
      timer = Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) => _read(counterMultiProvider.notifier).state = stopwatch.elapsed,
      );
    }
    if (playboard.isSolved) {
      timer?.cancel();
      timer = null;
      _read(counterMultiProvider.notifier).state = stopwatch.elapsed;
      stopwatch.reset();
    }
  }
}
