import 'package:equatable/equatable.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_config.dart';

abstract class PlayboardState extends Equatable {
  final PlayboardConfig config;

  const PlayboardState({required this.config});
}
