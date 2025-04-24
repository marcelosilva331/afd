import 'package:flutter/material.dart';

class ThemeController extends ChangeNotifier {
  var themeMode = ThemeMode.system;

  void changeTheme() {
    if (themeMode == ThemeMode.system) {
      themeMode = ThemeMode.dark;
    } else {
      themeMode = ThemeMode.system;
    }
    notifyListeners();
  }
}
