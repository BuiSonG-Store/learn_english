import 'package:flutter/material.dart';

class CustomGestureDetector extends StatelessWidget {
  final Widget? child;
  final Function? onTap;

  const CustomGestureDetector({Key? key, this.onTap, this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: child,
    );
  }
}
