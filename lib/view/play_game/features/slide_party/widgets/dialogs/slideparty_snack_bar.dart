import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showSlidepartyToast(BuildContext context, String text, Color color) {
  showToastWidget(
    Container(
      margin: const EdgeInsets.symmetric(horizontal: 40),
      alignment: Alignment.center,
      height: 56,
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2,
      ),
    ),
    context: context,
    animation: StyledToastAnimation.slideFromBottom,
    reverseAnimation: StyledToastAnimation.slideFromBottom,
    isHideKeyboard: true,
    duration: const Duration(seconds: 1, milliseconds: 500),
    curve: Curves.decelerate,
  );
}
