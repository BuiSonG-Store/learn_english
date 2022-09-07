import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext getContext() {
    return navigatorKey.currentState!.overlay!.context;
  }

  factory NavigationService() => _instance;

  NavigationService._internal();

  static final NavigationService _instance = NavigationService._internal();

  static NavigationService get instance => _instance;
  int _currentIndex = 0;

  Future<dynamic> navigateTo(String routeName, {dynamic arguments}) async {
    _currentIndex++;
    return navigatorKey.currentState!.pushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> popAndNavigateTo({dynamic result, required String routeName, dynamic arguments}) {
    return navigatorKey.currentState!.popAndPushNamed(routeName, arguments: arguments);
  }

  Future<dynamic> navigateAndRemove(String routeName, {dynamic arguments}) async {
    _currentIndex = 0;
    return navigatorKey.currentState?.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: arguments,
    );
  }

  dynamic popUntil({int? index}) {
    if (index != null) {
      if (_currentIndex == index) {
        return;
      }
      return navigatorKey.currentState?.popUntil((route) {
        if (_currentIndex != index) {
          _currentIndex -= 1;
          return false;
        }
        return _currentIndex == index;
      });
    }
    _currentIndex = 0;
    return navigatorKey.currentState?.popUntil((route) => route.isFirst);
  }

  Future<dynamic> navigateAndReplace(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.pushReplacementNamed(routeName, arguments: arguments);
  }

  dynamic pop({dynamic result}) {
    _currentIndex -= 1;
    return navigatorKey.currentState!.pop(result);
  }
}
