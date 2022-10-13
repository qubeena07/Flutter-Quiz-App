import 'package:flutter/material.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  void buttonTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class MyThemes {
  static final lightTheme = ThemeData(
      primaryColorLight: Colors.black,
      primaryColor: Colors.black,
      scaffoldBackgroundColor: Colors.white,
      primarySwatch: Colors.blue,
      colorScheme: const ColorScheme.light());
  static final darkTheme = ThemeData(
      primaryColor: Colors.white,
      colorScheme: const ColorScheme.dark(),
      scaffoldBackgroundColor: Colors.grey.shade900);
}
