import 'package:flutter/material.dart';
import 'package:learn_english/model/exercise_model.dart';

class AnswerItem extends StatelessWidget {
  final Answers answers;
  final bool isSelected;
  const AnswerItem({Key? key, this.isSelected = false, required this.answers}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: isSelected ? Colors.green : Colors.black38, width: 2)),
      child: Text(
        '${answers.answerKey}. ${answers.answerValue}',
        style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: FontWeight.w400),
      ),
    );
  }
}
