import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/helpers/auto_solve_helper.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/helpers/playboard_gesture_control_helper.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/helpers/playboard_keyboard_control_helper.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_config.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_keyboard_control.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/playboard.dart';
import 'package:learn_english/view/play_game/features/slide_party/widgets/buttons/models/slideparty_button_params.dart';

import '../../playboard/controllers/playboard_controller.dart';
import '../../playboard/controllers/playboard_info_controller.dart';

final singleModeControllerProvider = StateNotifierProvider.autoDispose<PlayboardController, PlayboardState>(
  (ref) {
    final color = ref.watch(playboardInfoControllerProvider.select((value) => value.color));
    final boardSize = ref.watch(playboardInfoControllerProvider.select((value) => value.boardSize));

    return SingleModePlayBoardController(
      ref.read,
      color: color,
      boardSize: boardSize,
    );
  },
);

final counterProvider = StateProvider.autoDispose<Duration>((ref) => const Duration(seconds: 0));
final singleModeSettingProvider = StateProvider.autoDispose<bool>((ref) => true);

class SingleModePlayBoardController extends PlayboardController<SinglePlayboardState>
    with PlayboardGestureControlHelper, PlayboardKeyboardControlHelper, AutoSolveHelper {
  SingleModePlayBoardController(
    this._read, {
    required this.color,
    required int boardSize,
  }) : super(
          SinglePlayboardState(
            playboard: Playboard.random(boardSize),
            config: NumberPlayboardConfig(color),
            bestStep: -1,
          ),
        ) {
    final playBoard = state.playboard;
    state = SinglePlayboardState(
      playboard: playBoard,
      config: state.config,
      bestStep: -1,
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () => state = SinglePlayboardState(
        playboard: state.playboard,
        step: state.step,
        bestStep: solveStep(state.playboard) ?? 1,
        config: state.config,
      ),
    );
  }

  final Reader _read;
  final ButtonColors color;

  Stopwatch stopwatch = Stopwatch();
  Timer? timer;
  bool isAuto = false;

  bool get isSolved => state.playboard.isSolved;

  List<PlayboardDirection>? _directions;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void changeDimension(int size) {
    if (size == state.playboard.size) return;
    final playBoard = Playboard.random(size);

    state = SinglePlayboardState(
      playboard: playBoard,
      bestStep: -1,
      config: state.config,
    );

    Future.delayed(
      const Duration(milliseconds: 500),
      () => state = SinglePlayboardState(
        playboard: state.playboard,
        config: state.config,
        step: state.step,
        bestStep: solve(state.playboard)?.length ?? -1,
      ),
    );

    stopwatch
      ..stop()
      ..reset();
    timer?.cancel();
    timer = null;
    _read(counterProvider.notifier).state = const Duration(seconds: 0);
  }

  void pause() {
    stopwatch.stop();
    timer?.cancel();
    timer = null;
  }

  void reset() {
    isAuto = false;
    if (_read(singleModeSettingProvider)) return;

    _directions = null;
    stopwatch
      ..stop()
      ..reset();
    timer?.cancel();
    timer = null;
    final playBoard = Playboard.random(state.playboard.size);
    state = SinglePlayboardState(
      playboard: playBoard,
      config: state.config,
      bestStep: -1,
    );
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        if (mounted) {
          state = SinglePlayboardState(
            playboard: state.playboard,
            bestStep: solveStep(state.playboard) ?? -1,
            config: state.config,
          );
        }
      },
    );
    _read(counterProvider.notifier).state = const Duration(seconds: 0);
  }

  void updatePlayBoardState(Playboard playBoard) {
    if (timer == null) {
      stopwatch.start();
      timer = Timer.periodic(
        const Duration(milliseconds: 30),
        (timer) => _read(counterProvider.notifier).state = stopwatch.elapsed,
      );
    }
    if (playBoard.isSolved) {
      timer?.cancel();
      timer = null;
      _read(counterProvider.notifier).state = stopwatch.elapsed;
      stopwatch.reset();
    }
    state = state.editPlayboard(playBoard);
  }

  void move(int index) {
    if (isAuto) return;
    if (state.playboard.isSolved) return;
    final playBoard = state.playboard.move(index);
    if (playBoard != null) updatePlayBoardState(playBoard);
  }

  // *Gesture control helper*

  @override
  Playboard? moveByGesture(PlayboardDirection direction) {
    if (isAuto) return null;
    if (_read(singleModeSettingProvider)) return null;
    if (state.playboard.isSolved) return null;
    final newBoard = defaultMoveByGesture(this, direction, state.playboard);
    if (newBoard != null) {
      updatePlayBoardState(newBoard);
    }

    return newBoard;
  }

  // *Keyboard control helper*

  @override
  PlayboardKeyboardControl get playBoardKeyboardControl => arrowControl;

  @override
  void moveByKeyboard(LogicalKeyboardKey pressedKey) {
    if (_read(singleModeSettingProvider)) return;
    if (state.playboard.isSolved) return;
    final newBoard = defaultMoveByKeyboard(
      playBoardKeyboardControl,
      pressedKey,
      state.playboard,
    );

    if (newBoard != null) {
      updatePlayBoardState(newBoard);
    }
  }

  // *Auto solve helper*
  void autoSolve(BuildContext context, Function playSound) async {
    isAuto = true;
    if (_read(singleModeSettingProvider)) return;
    if (state.playboard.isSolved) return;
    if (isSolving) return;
    _directions = solve(state.playboard);
    if (_directions == null || _directions!.isEmpty) return;
    isSolving = true;
    for (int index = 0; index < _directions!.length; index++) {
      final direction = _directions![index];
      Playboard? newBoard = state.playboard.moveHoleExact(direction);
      if (newBoard == null) {
        isSolving = false;
        break;
      }

      while (index + 1 < _directions!.length && _directions![index + 1] == direction) {
        index = index + 1;
        newBoard = newBoard!.moveHoleExact(direction);
        if (newBoard == null) {
          isSolving = false;
          break;
        }
      }
      try {
        playSound();
      } catch (_) {}
      if (newBoard == null) {
        isSolving = false;
        break;
      }
      updatePlayBoardState(newBoard);
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted == false) return;
      if (_directions == null) {
        isSolving = false;
        break;
      }
    }
  }
}
