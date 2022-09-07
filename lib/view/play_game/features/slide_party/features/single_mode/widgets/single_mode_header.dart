import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:showcaseview/showcaseview.dart';

import '../../../utils/breakpoint.dart';
import '../../../utils/durations.dart';
import '../../playboard/controllers/playboard_controller.dart';
import '../controllers/single_mode_controller.dart';

class SingleModeHeader extends ConsumerWidget {
  final GlobalKey keyFour;
  final GlobalKey keyFive;
  final GlobalKey keySix;
  const SingleModeHeader({
    Key? key,
    required this.keyFour,
    required this.keyFive,
    required this.keySix,
  }) : super(key: key);

  double _rSpacing(double playboardSize, int boardSize) => 2.5 * _tileSize(playboardSize, boardSize) / 49;

  double _tileSize(double playboardSize, int boardSize) => playboardSize / boardSize;

  double maxPlayboardSize(double screenSize, int boardSize) => screenSize - 16 - 2 * _rSpacing(screenSize, boardSize);

  static const bp = Breakpoint(small: 300, normal: 400, large: 500);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final boardSize = ref.watch(playboardControllerProvider.select((state) {
      if (state is SinglePlayboardState) {
        return state.playboard.size;
      }
      throw UnimplementedError('This cannot happen');
    }));
    final screenSize = MediaQuery.of(context).size;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Image.asset(
          'assets/icons/png_logo_banner.png',
          width: MediaQuery.of(context).size.width / 2,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxPlayboardSize(
              min(425, screenSize.shortestSide),
              boardSize,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final textStyle = Theme.of(context).textTheme.subtitle1!.copyWith(
                      fontSize: bp.responsiveValue(
                        constraints.biggest,
                        watch: 10,
                        tablet: 16,
                        defaultValue: 14,
                      ),
                    );
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Consumer(
                          builder: (context, ref, child) {
                            final step = ref.watch(playboardControllerProvider.select((state) {
                              if (state is SinglePlayboardState) {
                                return state.step;
                              }
                              throw UnimplementedError('This cannot happen');
                            }));
                            return Showcase(
                              key: keyFour,
                              description: 'You can see the steps played!',
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text.rich(
                                  TextSpan(
                                    text: 'STEP: ',
                                    style: const TextStyle(color: Colors.white),
                                    children: [
                                      TextSpan(
                                        text: '$step',
                                        style: textStyle.copyWith(
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  style: textStyle,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Center(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final duration = ref.watch(counterProvider);
                            return Showcase(
                              key: keyFive,
                              description: 'You can see the time played!',
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  Durations.watchFormat(duration),
                                  style: textStyle.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Consumer(builder: (context, ref, child) {
                          final bestStep = ref.watch(playboardControllerProvider.select((state) {
                            if (state is SinglePlayboardState) {
                              return state.bestStep;
                            }
                            throw UnimplementedError('This cannot happen');
                          }));
                          return Showcase(
                            key: keySix,
                            description: 'You can see the least number of steps to win the most to play!',
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text.rich(
                                TextSpan(
                                  text: 'AUTO: ',
                                  style: const TextStyle(color: Colors.white),
                                  children: [
                                    TextSpan(
                                      text: bestStep == -1 ? '?' : bestStep.toString(),
                                      style: textStyle.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                style: textStyle,
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
