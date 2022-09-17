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
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
        color: Colors.white,
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
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12))),
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
                      color: Colors.black,
                    )),
                  ),
                  Expanded(
                    child: Text(
                      title ?? '',
                      style: TextStyle(color: Colors.black, fontSize: 16),
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
                        style: TextStyle(color: Colors.blue),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
          Divider(height: 1, color: Colors.grey),
          Expanded(child: child ?? const SizedBox()),
        ],
      ),
    );
  }
}
