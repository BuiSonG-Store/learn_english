import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_config.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_state/playboard_state.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/playboard.dart';

class SinglePlayboardState extends PlayboardState {
  const SinglePlayboardState({
    required this.playboard,
    required this.bestStep,
    this.step = 0,
    required PlayboardConfig config,
  }) : super(config: config);

  final Playboard playboard;
  final int step;
  final int bestStep;

  SinglePlayboardState editPlayboard(Playboard playboard, [bool increment = true]) {
    ListEquality equality = const ListEquality();
    if (equality.equals(playboard.currentBoard, this.playboard.currentBoard)) {
      increment = false;
    }
    return SinglePlayboardState(
      playboard: playboard,
      config: config,
      step: increment ? step + 1 : step,
      bestStep: bestStep,
    );
  }

  SinglePlayboardState clone() => SinglePlayboardState(
        playboard: playboard.clone(),
        config: config,
        step: step,
        bestStep: bestStep,
      );

  @override
  List<Object?> get props => [playboard];
}
