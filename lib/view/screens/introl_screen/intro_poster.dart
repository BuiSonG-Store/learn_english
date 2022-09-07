import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IntroFooter extends StatelessWidget {
  const IntroFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 15),
          Text(
            'SINCE 2022',
            style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  fontSize: 8,
                  letterSpacing: 6,
                ),
          ),
        ],
      ),
    );
  }
}
