import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../../../provider/theme_provider.dart';
import '../../../../../../2048/helpers/sound_controller.dart';

class SelectLayoutMulti extends StatelessWidget {
  final ValueNotifier boardChosen;
  final ValueNotifier playerChosen;
  const SelectLayoutMulti({Key? key, required this.boardChosen, required this.playerChosen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.1)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('SELECT LAYOUT', style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white)),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SelectLayoutMultiItem(
                width: width / 4 - 20,
                boardChosen: boardChosen,
                playerChosen: playerChosen,
                urlImage: 'assets/images/box3x3.png',
                iNumber: 0,
              ),
              SelectLayoutMultiItem(
                width: width / 3 - 20,
                boardChosen: boardChosen,
                playerChosen: playerChosen,
                urlImage: 'assets/images/box4x4.png',
                iNumber: 1,
              ),
              SelectLayoutMultiItem(
                width: width / 2.5 - 20,
                boardChosen: boardChosen,
                playerChosen: playerChosen,
                urlImage: 'assets/images/box5x5.png',
                iNumber: 2,
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SelectLayoutMultiItem extends StatelessWidget {
  final double width;
  final ValueNotifier boardChosen;
  final ValueNotifier playerChosen;
  final String urlImage;
  final int iNumber;

  const SelectLayoutMultiItem(
      {Key? key,
      required this.width,
      required this.boardChosen,
      required this.playerChosen,
      required this.urlImage,
      required this.iNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int boxNumber = iNumber + 3;
    void _playSound() {
      if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
        SoundController.playClickSoundSlideParty();
      }
    }

    return GestureDetector(
      onTap: () {
        _playSound();
        boardChosen.value = List.generate(
          playerChosen.value.length,
          (i) => i == iNumber,
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            urlImage,
            width: width,
            color: boardChosen.value[iNumber] ? const Color(0xff4980FF) : Colors.white.withOpacity(0.3),
          ),
          Positioned(
            child: Text(
              '$boxNumber x $boxNumber',
              style: TextStyle(fontSize: boxNumber * 4, color: Colors.white, shadows: const [
                Shadow(
                  blurRadius: 12,
                  color: Colors.black,
                  offset: Offset(2, 2),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
