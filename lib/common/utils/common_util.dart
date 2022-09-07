import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class CommonUtil {
  static String textHelloInHome() {
    int hour = DateTime.now().hour;
    if (hour >= 4 && hour < 12) {
      return 'Chào buổi sáng 🌤️';
    }
    if (hour == 12) {
      return 'Chào buổi trưa 🌞';
    }
    if (hour >= 13 && hour <= 18) {
      return 'Chào buổi chiều 🌥️';
    }
    return 'Chào buổi tối 🌝';
  }

  static bool validateAndSave(GlobalKey<FormState> key) {
    FormState? form = key.currentState;
    if (form?.validate() ?? false) {
      form?.save();
      return true;
    }
    return false;
  }

  static void showSnackBar(BuildContext context, {String? title, Color? backgroundColor, Color? color}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      message: title ?? "err",
      backgroundColor: backgroundColor ?? Colors.grey,
      titleColor: Colors.white,
      icon: Icon(
        Icons.info_outline,
        size: 28.0,
        color: color ?? Colors.white,
      ),
      duration: const Duration(seconds: 3),
      borderRadius: BorderRadius.circular(8.0),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    ).show(context);
  }
}
