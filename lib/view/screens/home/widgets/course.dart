import 'package:flutter/material.dart';
import 'package:learn_english/view/screens/question_screen/question_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../model/course_model.dart';

class Course extends StatelessWidget {
  final ListCourse? model;

  const Course({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuestionScreen(id: model?.id.toString()),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Transform.rotate(
                  angle: 1.0,
                  child: CircularPercentIndicator(
                    radius: 40,
                    lineWidth: 8.0,
                    circularStrokeCap: CircularStrokeCap.round,
                    percent: model!.percentageComplete ?? 0 / 100,
                    // percent: content!.percentageComplete ?? 0 / 100,
                    progressColor: const Color(0xFFFFC800),
                    backgroundColor: Colors.grey.shade300,
                  ),
                ),
                const CircleAvatar(
                  backgroundColor: Color(0xFF2B70C9),
                  radius: 25,
                ),
                // model?.image == null || model?.image == ""
                //     ? Image.asset('assets/icons/logo.png')
                //     : Image.network(
                //         model!.image!,
                //         width: 15,
                //       )
              ],
            ),
            const SizedBox(height: 20),
            Text(
              (model!.title ?? ""),
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
