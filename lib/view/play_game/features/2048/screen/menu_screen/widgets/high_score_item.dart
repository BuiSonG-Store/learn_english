import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../config/constants.dart';

class HighScoreItem extends StatelessWidget {
  final int ranking;
  final String medalPath;
  final String backgrPath;
  final int score;
  final double textSize;

  const HighScoreItem({
    required this.score,
    required this.ranking,
    required this.medalPath,
    required this.backgrPath,
    required this.textSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sizeOfBox = Constants.sizeOfBox(context);
    return Container(
      width: sizeOfBox * 0.42,
      margin: EdgeInsets.only(bottom: sizeOfBox / size.height < 0.5 ? 5 : 1),
      child: Row(
        children: [
          Container(
            height: sizeOfBox * 0.075,
            width: sizeOfBox * 0.075,
            child: Image.asset(medalPath, fit: BoxFit.cover),
          ),
          SizedBox(width: sizeOfBox * 0.02),
          Container(
            height: 30,
            width: sizeOfBox * 0.28,
            child: Stack(
              children: [
                ClipRRect(child: SvgPicture.asset(backgrPath, fit: BoxFit.fitWidth)),
                Container(
                  padding: EdgeInsets.only(left: 8, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "N.O " + ranking.toString() + "  ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: "UTM Roman Classic",
                              fontSize: textSize,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      Expanded(child: Container()),
                      Text(
                        score > 3 ? score.toString() : " --- ",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontFamily: "UTM Roman Classic",
                              fontSize: textSize,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.fade,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
