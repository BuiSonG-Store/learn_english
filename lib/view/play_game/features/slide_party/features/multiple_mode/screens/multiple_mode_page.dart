import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/multi_setting/multiple_setting.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/multiple_mode/screens/multiple_playground.dart';
import 'package:learn_english/view/play_game/features/slide_party/features/playboard/playboard.dart';

class MultipleModePage extends ConsumerWidget {
  const MultipleModePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final playerCount = ref.watch(
      playboardControllerProvider.select((value) {
        return (value as MultiplePlayboardState).playerCount;
      }),
    );

    switch (playerCount) {
      case 0:
        return const MultipleSetting();
      default:
        return const MultiplePlayground();
    }
  }
}
