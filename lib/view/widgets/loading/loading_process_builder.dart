import 'package:flutter/material.dart';
import '../../../common/constants/common_cost.dart';
import 'loading_view.dart';

class LoadingProcessBuilder {
  static Future<void> showProgressDialog(BuildContext context) async {
    try {
      if (!Constant.isShowLoadingDialog) {
        Constant.isShowLoadingDialog = true;
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return WillPopScope(
              onWillPop: () async => false,
              child: AlertDialog(
                content: LoadingView(),
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12.0))),
              ),
            );
          },
        );
        Constant.isShowLoadingDialog = false;
      }
    } catch (_) {}
  }

  static void hideProgressDialog(BuildContext context) async {
    try {
      if (Constant.isShowLoadingDialog) {
        Navigator.pop(context);
        Constant.isShowLoadingDialog = false;
      }
    } catch (_) {}
  }
}
