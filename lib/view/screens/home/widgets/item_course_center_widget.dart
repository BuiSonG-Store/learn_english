import 'package:flutter/material.dart';
import 'package:learn_english/model/course_model.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ItemCourseCenterWidget extends StatelessWidget {
  final Exercises exercise;
  const ItemCourseCenterWidget({Key? key, required this.exercise}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 1.0,
                  child: CircularPercentIndicator(
                    radius: 35,
                    lineWidth: 10.0,
                    percent: 1.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: const Color(0xFFFFC800),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF2B70C9),
                  radius: 18,
                ),
                Image.asset(
                  'assets/icons/edit.png',
                  width: 15,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width/2 - 120,
              child: Text(exercise.name ?? "", style: Theme.of(context).textTheme.labelLarge, maxLines: 3,),
            )
          ],
        ),
      ),
    );
  }
}