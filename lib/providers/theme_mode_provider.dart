import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../theme/app_theme.dart';

class ThemeModeProvider with ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  // ThemeMode _mode = ThemeMode.system;

  ThemeData get themeData {
    if (_mode == ThemeMode.light) {
      return AppTheme.lightTheme;
    } else if (_mode == ThemeMode.dark) {
      return AppTheme.darkTheme;
    } else {
      final Brightness brightness =
          SchedulerBinding.instance.window.platformBrightness;
      if (brightness == Brightness.light) {
        return AppTheme.lightTheme;
      } else {
        return AppTheme.darkTheme;
      }
    }
  }

  ThemeMode get mode => _mode;

  void setMode(ThemeMode mode) {
    _mode = mode;
    notifyListeners();
  }

  void toggleMode() {
    if (_mode == ThemeMode.light) {
      _mode = ThemeMode.dark;
    } else if (_mode == ThemeMode.dark) {
      _mode = ThemeMode.light;
    } else {
      final Brightness brightness =
          SchedulerBinding.instance.window.platformBrightness;
      _mode = brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
    }

    notifyListeners();
  }

  ThemeMode getThemeMode() => _mode;
}
