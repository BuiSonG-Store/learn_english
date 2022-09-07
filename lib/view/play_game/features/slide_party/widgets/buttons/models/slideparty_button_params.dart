import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../cores/db/db_id_numbering.dart';
import '../../../utils/slideparty_colors.dart';

part 'slideparty_button_params.g.dart';

@HiveType(typeId: DbIdNumbering.buttonColorsId)
enum ButtonColors {
  @HiveField(0)
  blue,
  @HiveField(1)
  green,
  @HiveField(2)
  red,
  @HiveField(3)
  yellow,
}

extension BackgroundColor on ButtonColors {
  Color backgroundColor(BuildContext context) {
    switch (this) {
      case ButtonColors.blue:
        return Theme.of(context).brightness == Brightness.dark
            ? SlidepartyColors.dark.blueBg
            : SlidepartyColors.light.blueBg;
      case ButtonColors.green:
        return Theme.of(context).brightness == Brightness.dark
            ? SlidepartyColors.dark.greenBg
            : SlidepartyColors.light.greenBg;

      case ButtonColors.red:
        return Theme.of(context).brightness == Brightness.dark
            ? SlidepartyColors.dark.redBg
            : SlidepartyColors.light.redBg;

      case ButtonColors.yellow:
        return Theme.of(context).brightness == Brightness.dark
            ? SlidepartyColors.dark.yellowBg
            : SlidepartyColors.light.yellowBg;
      default:
        throw Exception('ButtonColors not found');
    }
  }
}

extension ColorSchemeExt on ButtonColors {
  Color get primaryColor {
    switch (this) {
      case ButtonColors.red:
        return const Color(0xFF8DC6FF);
      case ButtonColors.blue:
        return const Color(0xFF30B7EE);
      case ButtonColors.green:
        return const Color(0xFF058DF3);
      case ButtonColors.yellow:
        return const Color(0xFF3F79FE);
    }
  }

  Color get colorButton3x3 {
    switch (this) {
      case ButtonColors.red:
        return const Color(0xFF30B7EE);
      case ButtonColors.blue:
        return const Color(0xFF8DC6FF);
      case ButtonColors.green:
        return const Color(0xFF058DF3);
      case ButtonColors.yellow:
        return const Color(0xFF3F79FE);
    }
  }

  Color get colorButton4x4 {
    switch (this) {
      case ButtonColors.red:
        return const Color(0xFF058DF3);
      case ButtonColors.blue:
        return const Color(0xFF30B7EE);
      case ButtonColors.green:
        return const Color(0xFF8DC6FF);
      case ButtonColors.yellow:
        return const Color(0xFF3F79FE);
    }
  }

  Color get colorButton5x5 {
    switch (this) {
      case ButtonColors.red:
        return const Color(0xFF3F79FE);
      case ButtonColors.blue:
        return const Color(0xFF058DF3);
      case ButtonColors.green:
        return const Color(0xFF30B7EE);
      case ButtonColors.yellow:
        return const Color(0xFF8DC6FF);
    }
  }
}

extension ThemeBaseOnColor on ButtonColors {
  ThemeData adaptiveTheme(BuildContext context) =>
      Theme.of(context).brightness == Brightness.light ? lightTheme : darkTheme;

  ThemeData get lightTheme => FlexColorScheme.light(
        fontFamily: 'Bai_Jamjuree',
        primary: primaryColor,
        blendLevel: 20,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        onPrimary: Colors.white,
      ).toTheme;
  ThemeData get darkTheme => FlexColorScheme.dark(
        fontFamily: 'Bai_Jamjuree',
        primary: primaryColor,
        blendLevel: 20,
        surfaceMode: FlexSurfaceMode.highSurfaceLowScaffold,
        onPrimary: Colors.white,
      ).toTheme;
}

enum ButtonSize { large, square }
