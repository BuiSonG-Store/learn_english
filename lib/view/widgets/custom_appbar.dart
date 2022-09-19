import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  final String title;
  final bool haveIcon1;
  final bool haveIcon2;
  final bool haveIconPop;
  final Function? onRight2Tap;
  final Function? onRight1Tap;
  final String? icon1;
  final String? icon2;
  const CustomAppbar({
    Key? key,
    required this.title,
    required this.haveIcon1,
    required this.haveIcon2,
    required this.haveIconPop,
    this.onRight1Tap,
    this.onRight2Tap,
    this.icon1,
    this.icon2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 50,
            child: Row(
              children: [
                haveIconPop
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      )
                    : const SizedBox(),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
                haveIcon1
                    ? GestureDetector(
                        onTap: () {
                          onRight1Tap!();
                        },
                        child: SizedBox(
                          width: 50,
                          height: 56,
                          child: Center(
                            child: Image.asset(
                              icon1 ?? '',
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                haveIcon2
                    ? GestureDetector(
                        onTap: () {
                          onRight2Tap!();
                        },
                        child: SizedBox(
                          width: 50,
                          height: 56,
                          child: Center(
                            child: Image.asset(
                              icon2 ?? '',
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(width: 12),
              ],
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
