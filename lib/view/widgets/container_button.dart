import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/custom_gesturedetector.dart';

class ContainerButton extends StatefulWidget {
  final String? text;
  final Function? press;
  final Color? color;
  final double? fontSize;
  const ContainerButton({
    Key? key,
    this.text,
    this.press,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  State<ContainerButton> createState() => _ContainerButtonState();
}

class _ContainerButtonState extends State<ContainerButton> {
  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: widget.press,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        decoration:
            BoxDecoration(color: widget.color ?? const Color(0xFF5370F1), borderRadius: BorderRadius.circular(25)),
        alignment: Alignment.center,
        child: Text(
          widget.text ?? '',
          style: TextStyle(fontSize: widget.fontSize ?? 14, fontWeight: FontWeight.w600, color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
