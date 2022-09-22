import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/model/exercise_model.dart';

class AnswerItem extends StatelessWidget {
  final Answers answers;
  const AnswerItem({Key? key, required this.answers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 6),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: (answers.isSelected ?? false) ? Colors.green : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: (answers.isSelected ?? false) ? Colors.green : Colors.black38, width: 2)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 10),
          Expanded(
              child: Text(
            utf8.decode((answers.answerValue ?? '').runes.toList()),
            style: TextStyle(
                color: (answers.isSelected ?? false) ? Colors.white : Colors.black87, fontWeight: FontWeight.w400),
            maxLines: 2,
          ))
        ],
      ),
    );
  }
}
