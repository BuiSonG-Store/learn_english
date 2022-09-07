import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/constants.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/helper_function.dart';
import 'package:learn_english/view/play_game/features/2048/helpers/sound_controller.dart';
import 'package:learn_english/view/play_game/features/2048/provider/matrix_provider.dart';
import 'package:learn_english/view/play_game/widgets/individual_tile.dart';
import 'package:provider/provider.dart';

import '../../../../../provider/theme_provider.dart';
import '../../../../../widgets/common_showcase.dart';

class GameGrid extends StatefulWidget {
  final GlobalKey gridkey;
  const GameGrid({required this.gridkey, Key? key}) : super(key: key);

  @override
  _GameGridState createState() => _GameGridState();
}

class _GameGridState extends State<GameGrid> {
  @override
  Widget build(BuildContext context) {
    double sizeOfBox = Constants.sizeOfBox(context) * 0.91;
    if (sizeOfBox > 600) sizeOfBox = 600;
    return Consumer<MatrixProvider>(builder: (context, matrixProvider, child) {
      return CommonShowcase(
        showkey: widget.gridkey,
        title: Constants.gridTitle,
        description: Constants.gridDesc,
        child: Container(
          width: sizeOfBox,
          height: sizeOfBox,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Theme.of(context).backgroundColor,
          ),
          margin: EdgeInsets.all(Constants.sizeOfBox(context) * 0.04),
          padding: EdgeInsets.all(Constants.sizeOfBox(context) * 0.04),
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: GridView.count(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                primary: false,
                crossAxisSpacing: Constants.sizeOfBox(context) * 0.005,
                mainAxisSpacing: Constants.sizeOfBox(context) * 0.005,
                crossAxisCount: 4,
                children: HelperFunction.flatten(matrixProvider.curGrid)
                    .map((cell) => IndividualTile(key: ValueKey('${cell.x}${cell.y}'), cell: cell))
                    .toList()),
            onHorizontalDragEnd: (draggedDetails) {
              if (draggedDetails.primaryVelocity! > 0) {
                if (matrixProvider.isGenerating == false) {
                  matrixProvider.isGenerating = true;
                  matrixProvider.onLeft();
                  generateCellValue(context);
                }
              } else if (draggedDetails.primaryVelocity! < 0) {
                if (matrixProvider.isGenerating == false) {
                  matrixProvider.isGenerating = true;
                  matrixProvider.onRight();
                  generateCellValue(context);
                }
              }
            },
            onVerticalDragEnd: (draggedDetails) {
              if (draggedDetails.primaryVelocity! > 0) {
                if (matrixProvider.isGenerating == false) {
                  matrixProvider.isGenerating = true;
                  matrixProvider.onDown();
                  generateCellValue(context);
                }
              } else if (draggedDetails.primaryVelocity! < 0) {
                if (matrixProvider.isGenerating == false) {
                  matrixProvider.isGenerating = true;
                  matrixProvider.onUp();
                  generateCellValue(context);
                }
              }
            },
          ),
        ),
      );
    });
  }

  void generateCellValue(BuildContext context) async {
    var matrix = MatrixProvider.of(context);
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    if (sound) {
      if (matrix.checkMerge()) {
        SoundController.playSoundMerge();
      } else if (matrix.checkLatest()) {
        SoundController.playSoundSwipe();
      }
    }
    await Future.delayed(const Duration(milliseconds: 50));
    matrix.isGenerating = false;
  }
}
