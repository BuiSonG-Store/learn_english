import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:learn_english/view/play_game/config/sound_controller.dart';
import 'package:provider/provider.dart';

import '../provider/theme_provider.dart';

class CommonButton extends StatefulWidget {
  final String imgPath;
  final double size;
  final VoidCallback onTap;
  bool isEnabled;
  bool isSoundButton;

  CommonButton({
    required this.imgPath,
    required this.onTap,
    required this.size,
    this.isSoundButton: false,
    this.isEnabled: true,
    Key? key,
  }) : super(key: key);

  @override
  _CommonButtonState createState() => _CommonButtonState();
}

class _CommonButtonState extends State<CommonButton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool isTap = false;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    animation = Tween<double>(begin: 1.2, end: 1).animate(controller);
    controller.forward(from: 0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool sound = Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn;
    return SizedBox(
      height: widget.size,
      width: widget.size,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Transform.scale(scale: animation.value, child: child);
        },
        child: GestureDetector(
          onTap: isTap
              ? null
              : () async {
                  setState(() => isTap = true);
                  Timer(
                    const Duration(milliseconds: 350),
                    () => setState(() => isTap = false),
                  );
                  if (widget.isEnabled == false) {
                    return;
                  } else {
                    controller.forward(from: 0);
                    if (sound && widget.isSoundButton == false) {
                      SoundController.playSoundPress();
                    }
                    if (sound == false && widget.isSoundButton == true) {
                      SoundController.playSoundPress();
                    }
                    widget.onTap();
                  }
                },
          child: widget.isEnabled
              ? SvgPicture.asset(widget.imgPath, fit: BoxFit.cover)
              : Opacity(
                  opacity: 0.3,
                  child: SvgPicture.asset(widget.imgPath, fit: BoxFit.cover),
                ),
        ),
      ),
    );
  }
}
