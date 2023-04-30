import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

final lightTheme1 = ThemeData.light().copyWith(
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.teal,
    secondary: Colors.grey,
    // Primary: Colors.blue or Colors.teal
    // Secondary: Colors.grey or Colors.indigo
    // Accent: Colors.pink or Colors.purple
    // Text: Colors.black
    // Background: Colors.white
    // Button: Colors.blue or Colors.teal
    // Icon: Colors.black
    // Divider: Colors.grey
  ),
);

final darkTheme1 = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark().copyWith(
    primary: Colors.yellow,
    secondary: const Color(0xFFCCCCCC), // Color(0xFF555555)
    // Primary Color: #F8D030 (a bright, warm yellow)
    // Background Color: #191B28 (a deep, dark blue)
    // Accent Color: #323549 (a muted, dark gray-purple)
    // Text Color: #FFFFFF (white)
    // Button Color: #F8D030 (same as primary color)
    // Icon Color: #FFFFFF (white)
    // Divider Color: #323549 (same as accent color)
  ),
);

enum ThemeModeType { light, dark, system }

class ThemeController extends ChangeNotifier {
  static const String _themeModeKey = 'THEME_MODE';

  ThemeModeType _themeMode = ThemeModeType.system;

  ThemeModeType get themeMode => _themeMode;

  ThemeController() {
    _loadThemeMode();
  }

  Future<void> setThemeMode(ThemeModeType mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_themeModeKey, mode.index);
    _themeMode = mode;
    notifyListeners();
  }

  Future<void> _loadThemeMode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(_themeModeKey) ?? ThemeModeType.system.index;
    _themeMode = ThemeModeType.values[index];
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    switch (_themeMode) {
      case ThemeModeType.light:
        return ThemeMode.light;
      case ThemeModeType.dark:
        return ThemeMode.dark;
      case ThemeModeType.system:
      default:
        return ThemeMode.system;
    }
  }
}
