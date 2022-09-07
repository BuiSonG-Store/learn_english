import 'package:flutter/material.dart';

enum AppTheme {
  Dark,
  Light,
}

String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    fontFamily: 'Poppins',
    disabledColor: const Color(0xFFA2AAB7),
    brightness: Brightness.light,
    hintColor: const Color(0xFFA8C776),
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFffffff),
    dividerColor: const Color(0xFFE8EBF9),
    accentColor: const Color(0xFF122640),
    errorColor: const Color(0xFFEF5350),
    buttonColor: const Color(0xFFB5C3FC),
    backgroundColor: const Color(0xFFB5C3FC),
    canvasColor: const Color(0xFF717966),
    dialogBackgroundColor: Colors.white,
    shadowColor: const Color(0xFFA2AAB7),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.6,
    ),
    dividerTheme: DividerThemeData(
      thickness: 1,
      color: const Color(0xFF6A7BA6).withOpacity(0.3),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFFF4F6FC),
      shape: const RoundedRectangleBorder(borderRadius: const BorderRadius.all(const Radius.circular(10))),
      elevation: 2,
      shadowColor: Colors.grey.withOpacity(0.2),
    ),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.white,
      iconTheme: const IconThemeData(color: const Color(0xFF3150C3)),
      titleTextStyle: const TextStyle(fontSize: 14, color: Color(0xFF122641), fontWeight: FontWeight.w400),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF6A7BA6)),
      focusColor: const Color(0xFFFF9900).withOpacity(0.7),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.white, width: 1)),
      fillColor: Colors.white,
      filled: true,
      errorMaxLines: 3,
      hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: const Color(0xFF6A7BA6).withOpacity(0.7)),
      errorStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: const Color(0xFFD3323D)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: const Color(0xFFFFFFFF),
        primary: const Color(0xFFFF9900),
        minimumSize: const Size(100, 40),
        textStyle: const TextStyle(color: Colors.red, fontWeight: FontWeight.w400, fontSize: 14),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: const Color(0xFFFF9900),
      unselectedItemColor: Color(0xFF8696D1),
      selectedIconTheme: IconThemeData(color: Color(0xFF3150C3)),
      unselectedIconTheme: const IconThemeData(color: const Color(0xFFA2AAB7)),
      backgroundColor: Colors.white,
      selectedLabelStyle: const TextStyle(fontSize: 12, color: Color(0xFF3150C3)),
      unselectedLabelStyle: TextStyle(fontSize: 12, color: Color(0xFFA2AAB7)),
      showUnselectedLabels: true,
      elevation: 8,
    ),
    textTheme: const TextTheme(
      headline1: const TextStyle(color: Color(0xFF122641), fontWeight: FontWeight.w400, fontSize: 24),
      headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400),
      headline5: const TextStyle(color: const Color(0xFF122641), fontWeight: FontWeight.w400, fontSize: 16),
      headline6: const TextStyle(color: const Color(0xFF122641), fontWeight: FontWeight.w400, fontSize: 14),
      button: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14, letterSpacing: 3),
      caption: const TextStyle(color: const Color(0xFF6A7BA6), fontWeight: FontWeight.w300, fontSize: 12),
      bodyText1: TextStyle(color: Color(0xFF6A7BA6), fontWeight: FontWeight.w600, fontSize: 14),
      bodyText2: TextStyle(color: const Color(0xFF122641), fontWeight: FontWeight.w400, fontSize: 16),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      elevation: 18,
    ),
  ),
  AppTheme.Dark: ThemeData(
    fontFamily: 'Barlow_Condensed',
    disabledColor: const Color(0xff1f1f1f),
    brightness: Brightness.dark,
    primaryColorDark: const Color(0xFF2D2D2D),
    hintColor: const Color(0xffbdbcbb),
    scaffoldBackgroundColor: const Color(0xFF8078f5),
    primaryColor: const Color(0xFF313C63),
    cardTheme: const CardTheme(
      color: Color(0xff1C284D),
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(const Radius.circular(10))),
      elevation: 0,
    ),
    buttonColor: const Color(0xFF707070),
    dialogTheme: DialogTheme(
      backgroundColor: const Color(0xff1A243F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.6,
    ),
    backgroundColor: const Color(0xFF465073),
    canvasColor: const Color(0xff2C364E),
    dividerColor: const Color(0x80243985),
    dividerTheme: const DividerThemeData(
      thickness: 1,
    ),
    accentColor: const Color(0xFFFFFFFF),
    errorColor: const Color(0xFFD5415C),
    dialogBackgroundColor: const Color(0xff2C364E),
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Color(0xff1A243F),
      iconTheme: IconThemeData(
        color: Color(0xFF3150C3),
      ),
      titleTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFFA5BDEA),
        fontWeight: FontWeight.w400,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        onPrimary: const Color(0xFFFFFFFF),
        primary: const Color(0xff3150C3),
        minimumSize: const Size(100, 40),
        textStyle: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: Color(0xFF3150C3),
      unselectedItemColor: Color(0xFF203167),
      selectedIconTheme: IconThemeData(color: Color(0xFF3150C3)),
      unselectedIconTheme: const IconThemeData(color: Color(0xFF203167)),
      backgroundColor: Color(0xff1A243F),
      selectedLabelStyle: TextStyle(fontSize: 12, color: Color(0xFF3150C3)),
      unselectedLabelStyle: TextStyle(fontSize: 12, color: Color(0xFF203167)),
      showUnselectedLabels: true,
      elevation: 8,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      clipBehavior: Clip.antiAlias,
      backgroundColor: const Color(0xff1A243F),
      elevation: 0,
    ),
    textTheme: const TextTheme(
      headline1: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold, fontSize: 22),
      headline2: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
      headline5: TextStyle(color: const Color(0xFF262626), fontWeight: FontWeight.w600, fontSize: 16),
      headline6: const TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.w600, fontSize: 14),
      button: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w600),
      caption: const TextStyle(color: Color(0xFFA5BDEA), fontWeight: FontWeight.w400, fontSize: 12),
      bodyText1: const TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 14),
      bodyText2: TextStyle(color: Color(0xFFA5BDEA), fontWeight: FontWeight.w400, fontSize: 16),
    ),
  ),
};
