import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trackbuzz/utils/constants.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeData _currentTheme = appThemeDark;

  ThemeData get currentTheme => _currentTheme;

  Future<void> initialize() async {
    await _loadThemeFromPrefs();
  }

  Future<void> _loadThemeFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();

    final surface = prefs.getString('surface') ?? 'FF0D0D0D';
    final primary = prefs.getString('primary') ?? 'FF590253';
    final secondary = prefs.getString('secondary') ?? 'FFF2F2F2';

    _currentTheme = ThemeData(
      colorScheme: ColorScheme.dark(
        surface: Color(int.parse(surface, radix: 16)),
        primary: Color(int.parse(primary, radix: 16)),
        secondary: Color(int.parse(secondary, radix: 16)),
      ),
    );

    notifyListeners();
  }
}
