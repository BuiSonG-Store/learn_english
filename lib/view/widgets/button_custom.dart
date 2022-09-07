import 'package:flutter/material.dart';
import 'package:learn_english/view/widgets/custom_gesturedetector.dart';

class ButtonCustom extends StatelessWidget {
  final Color? color;
  final Function? onTap;
  final String title;
  const ButtonCustom(
      {Key? key, this.color, this.onTap, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomGestureDetector(
      onTap: (){
        if(onTap != null){
          onTap!();
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color ?? Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
