import 'package:flutter/material.dart';

class BackgroundItem extends StatelessWidget {
  final double width;
  final double height;

  final Widget widget;
  const BackgroundItem({Key? key, required this.widget, required this.width, required this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff9405FF), Color(0xff08F1FF), Color(0xff9405FF), Color(0xff08F1FF)],
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(3),
        height: height,
        width: width,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff040630), Color(0xff185E93)],
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(border: Border.all(color: const Color(0xff6D6E87))),
          child: widget,
        ),
      ),
    );
  }
}
