import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:learn_english/model/rank_model.dart';

class ItemRank extends StatelessWidget {
  final Top10User? model;
  const ItemRank({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(1, 1), // Shadow position
          ),
        ],
      ),
      child: Row(
        children: [
          imageTop(model?.rank ?? 0, context),
          const SizedBox(width: 12),
          Text(
            utf8.decode((model?.name ?? '').runes.toList()),
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const Spacer(),
          Image.asset('assets/icons/fire.png'),
          Text(
            model?.score.toString() ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }

  Widget imageTop(int top, context) {
    if (top == 1) {
      return Image.asset(
        'assets/icons/first_rank.png',
        width: 30,
      );
    } else if (top == 2) {
      return Image.asset(
        'assets/icons/second_rank.png',
        width: 30,
      );
    } else if (top == 3) {
      return Image.asset(
        'assets/icons/third-rank.png',
        width: 30,
      );
    }
    return Container(
      alignment: Alignment.center,
      width: 30,
      height: double.infinity,
      child: Text(
        '${top}.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );
  }
}
