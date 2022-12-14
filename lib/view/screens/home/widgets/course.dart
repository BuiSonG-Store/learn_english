import 'dart:math';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../../../model/course_model.dart';
import '../../course/course_screen.dart';

class Course extends StatelessWidget {
  final ListCourse? model;

  const Course({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
          SoundController.playSoundPress();
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseScreen(
              id: model!.id.toString(),
              title: model!.title.toString(),
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 0,
                  child: CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 10.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: min(1, (model!.percentageComplete ?? 0) / 100),
                    progressColor: const Color(0xFFFFC800),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF2B70C9),
                  radius: 25,
                ),
                model?.image == null || model?.image == ""
                    ? Image.asset(
                        'assets/icons/logo.png',
                        width: 30,
                      )
                    : Image.network(
                        model!.image!,
                        width: 30,
                      )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              utf8.decode((model!.title ?? "").runes.toList()),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
