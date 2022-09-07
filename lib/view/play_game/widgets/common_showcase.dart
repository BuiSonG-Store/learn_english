import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';

class CommonShowcase extends StatefulWidget {
  final String title;
  final String description;
  final GlobalKey showkey;
  final Widget child;

  const CommonShowcase({
    required this.showkey,
    required this.child,
    required this.title,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  State<CommonShowcase> createState() => _CommonShowcaseState();
}

class _CommonShowcaseState extends State<CommonShowcase> {
  @override
  Widget build(BuildContext context) {
    return Showcase(
      radius: const BorderRadius.all(Radius.circular(5)),
      overlayPadding: const EdgeInsets.all(5),
      key: widget.showkey,
      title: widget.title,
      description: widget.description,
      showcaseBackgroundColor: Colors.white,
      child: widget.child,
    );
  }
}
