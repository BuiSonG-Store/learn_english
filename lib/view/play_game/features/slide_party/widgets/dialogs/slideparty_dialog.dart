import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/provider/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../2048/helpers/sound_controller.dart';

class SlidepartyDialog extends StatefulWidget {
  const SlidepartyDialog({
    Key? key,
    required this.title,
    required this.content,
    required this.actions,
    this.height,
    this.width,
    required this.description,
  }) : super(key: key);

  final String title;
  final String description;
  final Widget content;
  final List<Widget> actions;
  final double? height;
  final double? width;

  @override
  State<SlidepartyDialog> createState() => _SlidepartyDialogState();
}

class _SlidepartyDialogState extends State<SlidepartyDialog> {
  @override
  void initState() {
    if (Provider.of<ThemeProviderGame>(context, listen: false).isSoundOn) {
      SoundController.playBackGrSoundSlideParty();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? 200,
      width: widget.width ?? double.maxFinite,
      decoration: BoxDecoration(
        color: const Color(0xff2F407E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),
              ),
            ),
            Center(
              child: Text(
                widget.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey),
              ),
            ),
            widget.content,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.actions,
            ),
          ],
        ),
      ),
    );
  }
}
