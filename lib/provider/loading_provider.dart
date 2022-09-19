import 'package:flutter/material.dart';

class LoadingProvider extends ChangeNotifier {
  factory LoadingProvider() => _instance;

  LoadingProvider._();

  static final LoadingProvider _instance = LoadingProvider._();

  static LoadingProvider get instance => _instance;

  bool loading = false;

  void onShowLoading(bool showLoading) async {
    loading = showLoading;
    await Future.delayed(const Duration(milliseconds: 50));
    notifyListeners();
  }
}
