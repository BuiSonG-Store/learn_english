import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/custom_gesturedetector.dart';

class CustomButtonText extends StatelessWidget {
  String? text;
  Color? background;
  Function? onTab;
  CustomButtonText({Key? key, this.text, this.background, this.onTab}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: onTab,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: background ?? const Color(0xFF5370F1),
        ),
        alignment: Alignment.center,
        child: Text(
          text ?? "",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
