import 'package:flutter/material.dart';
import 'package:learn_english/view/play_game/config/theme.dart';
import 'package:learn_english/view/play_game/features/shared_preference_service.dart';

class ThemeProviderGame with ChangeNotifier {
  bool isSoundOn = true;

  void setSound(bool sound) {
    isSoundOn = sound;
    SharedPreferenceService.setSound(isSoundOn);
    notifyListeners();
  }

  void changeSound() {
    isSoundOn = !isSoundOn;
    SharedPreferenceService.setSound(isSoundOn);
    notifyListeners();
  }

  ThemeManager() {
    _loadTheme();
  }

  ThemeData _themeData = appThemeData[AppTheme.Light] ?? ThemeData();

  ThemeData get themeData {
    if (_themeData == null) {
      _themeData = appThemeData[AppTheme.Light] ?? ThemeData();
    }
    return _themeData;
  }

  setTheme(AppTheme theme) async {
    _themeData = appThemeData[theme] ?? ThemeData();
    SharedPreferenceService.setTheme(theme);
    notifyListeners();
  }

  void _loadTheme() async {
    _themeData = await SharedPreferenceService.getTheme();
    notifyListeners();
  }
}
