import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/theme.dart';

class SharedPreferenceService {
  static setTheme(AppTheme theme) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('themeMode', AppTheme.values.indexOf(theme));
  }

  static Future<ThemeData> getTheme() async {
    var prefs = await SharedPreferences.getInstance();
    int preferredTheme = prefs.getInt('themeMode') ?? 1;
    ThemeData _themeData = appThemeData[AppTheme.values[preferredTheme]] ?? ThemeData();
    return _themeData;
  }

  static Future<int> getCurScore() async {
    var prefs = await SharedPreferences.getInstance();
    int score = prefs.getInt("cur_score") ?? 0;
    return score;
  }

  static Future<void> setCurScore(int curScore) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt("cur_score", curScore);
  }



  static Future<void> clearMatrix() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove("matrix");
  }


  static Future<void> setHighScore(List<int> list) async {
    var prefs = await SharedPreferences.getInstance();
    List<String> strList = list.map((i) => i.toString()).toList();
    prefs.setStringList("high_score", strList);
  }

  static Future<List<int>> getHighScore() async {
    var prefs = await SharedPreferences.getInstance();
    List<String> strList = await prefs.getStringList('high_score') ?? [];
    List<int> intList = strList.map((i) => int.parse(i)).toList();
    return intList;
  }

  static Future<bool> getSound() async {
    var prefs = await SharedPreferences.getInstance();
    bool sound = await prefs.getBool('sound') ?? true;
    return sound;
  }

  static Future<void> setSound(bool sound) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('sound', sound);
  }

  static Future<void> setUndo(int undo) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('undo', undo);
  }

  static Future<int> getUndo() async {
    var prefs = await SharedPreferences.getInstance();
    int undo = prefs.getInt('undo') ?? 5;
    return undo;
  }

  static Future<bool> getFirstTime() async {
    var prefs = await SharedPreferences.getInstance();
    bool first = prefs.getBool('isFirst') ?? true;
    return first;
  }

  static Future<void> setFirstTime() async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirst', false);
  }

  static Future<bool> getFirstTimeSlideParty() async {
    var prefs = await SharedPreferences.getInstance();
    bool first = prefs.getBool('FirstTimeSlideParty') ?? true;
    return first;
  }

  static Future setFirstTimeSlideParty() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('FirstTimeSlideParty', false);
  }
}
