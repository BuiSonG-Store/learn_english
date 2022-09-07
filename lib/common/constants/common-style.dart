import 'package:flutter/material.dart';

abstract class CommonStyle {
  TextStyle textRegular(
    BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w300,
      color: color ?? Theme.of(context).textTheme.bodyText1?.color,
    );
  }

  static TextStyle textMedium(
    BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: color ?? Theme.of(context).textTheme.bodyText1?.color,
    );
  }

  static TextStyle textBold(
    BuildContext context, {
    Color? color,
    double? fontSize,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 12,
      fontWeight: FontWeight.w400,
      color: color ?? Theme.of(context).textTheme.bodyText1?.color,
    );
  }
}

class MaterialColors {
  MaterialColors();

  static const MaterialColor blue = MaterialColor(
    0xFF3967D5,
    <int, Color>{
      50: Color(0xFFe0e0e0),
      100: Color(0xFFb3b3b3),
      200: Color(0xFF808080),
      300: Color(0xFF4d4d4d),
      400: Color(0xFF262626),
      500: Color(0xFF3967D5),
      600: Color(0xFF000000),
      700: Color(0xFF3967D5),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
      1000: Color(0xFFFFFFFF),
      1100: Color(0xFF338be8),
      1200: Color(0xFFCBCBCB),
      1300: Color(0xFFFF9900),
    },
  );
}
