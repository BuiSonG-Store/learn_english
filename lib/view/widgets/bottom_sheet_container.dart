import 'package:flutter/material.dart';

class BottomSheetContainer extends StatelessWidget {
  final Widget? child;
  final String? title;
  final Function? onLeftTap;
  final Function? onRightTap;
  final String? textButtonRight;

  const BottomSheetContainer({
    Key? key,
    this.child,
    this.title,
    this.onLeftTap,
    this.onRightTap,
    this.textButtonRight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        color: Theme.of(context).backgroundColor,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              if (onLeftTap != null) {
                onLeftTap!();
              } else {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12))),
              child: Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                      ),
                    ),
                    child: const Center(
                        child: Icon(
                      Icons.close,
                      size: 20,
                    )),
                  ),
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: Theme.of(context).textTheme.titleSmall,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (onRightTap != null) {
                        onRightTap!();
                      }
                    },
                    child: Container(
                      width: 56,
                      height: 56,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(12),
                        ),
                      ),
                      child: Center(
                          child: Text(
                        textButtonRight ?? '',
                        style: const TextStyle(color: Colors.blue),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(height: 1, color: Colors.grey),
          Expanded(child: child ?? const SizedBox()),
        ],
      ),
    );
  }
}
