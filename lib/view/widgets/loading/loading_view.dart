import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/common-style.dart';

class LoadingView extends StatefulWidget {
  @override
  LoadingViewState createState() => LoadingViewState();
}

class LoadingViewState extends State<LoadingView> {
  late int _current;
  List<int> _listDot = [0, 1, 2];

  @override
  void initState() {
    _current = _listDot[0];
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      while (true) {
        await Future.delayed(const Duration(milliseconds: 300));
        if (mounted) {
          setState(() {
            _current == 3 ? _current = 0 : _current = _current + 1;
          });
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/gif/loading.gif',
          width: 170,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _listDot.length,
            (index) {
              return Container(
                width: 5,
                height: 5,
                margin: const EdgeInsets.only(left: 2.0, right: 2, top: 12, bottom: 6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index ? MaterialColors.blue[1100] : MaterialColors.blue[1200],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
