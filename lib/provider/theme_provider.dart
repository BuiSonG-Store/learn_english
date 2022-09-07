import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData? _selectedTheme;
  Typography? defaultTypography;
  SharedPreferences? prefs;

  ThemeData dark = ThemeData.dark().copyWith(
    backgroundColor: Colors.black,
    indicatorColor: Colors.white,
    shadowColor: Colors.black,
  );

  ThemeData light = ThemeData.light().copyWith(
    backgroundColor: Colors.white,
    indicatorColor: Colors.black,
    shadowColor: Colors.white,
  );

  ThemeProvider(bool darkThemeOn) {
    _selectedTheme = darkThemeOn ? dark : light;
  }

  Future<void> swapTheme() async {
    prefs = await SharedPreferences.getInstance();

    if (_selectedTheme == dark) {
      _selectedTheme = light;
      await prefs?.setBool("darkTheme", false);
    } else {
      _selectedTheme = dark;
      await prefs?.setBool("darkTheme", true);
    }

    notifyListeners();
  }

  ThemeData? getTheme() => _selectedTheme;
}
