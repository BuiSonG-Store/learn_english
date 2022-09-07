import 'package:flutter/services.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/models/playboard_keyboard_control.dart';

class PlayboardSkillKeyboardControl {
  final PlayboardKeyboardControl control;
  final LogicalKeyboardKey activeSkillKey;

  const PlayboardSkillKeyboardControl({
    required this.control,
    required this.activeSkillKey,
  });
}
