import 'package:flutter/material.dart';

import '../../data/local_data/local_shared_preferences.dart';
import '../constants/app_constants.dart';

class ThemeConfig extends ChangeNotifier {
  bool _isDarkTheme = false;
  LocalSharePreferences localSharePref = LocalSharePreferences();

  bool get getCurrentTheme => _isDarkTheme;

  void toggleTheme() {
    _isDarkTheme = _isDarkTheme ? false : true;
    localSharePref.setBoolToPrefs(themeKey, _isDarkTheme);
    notifyListeners();
  }
}
